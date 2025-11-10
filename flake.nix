{
  description = "vbdjames's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    firefox-addons,
    ...
  }: let
    inherit (self) outputs;
    # Supported systems for flake packages, shell, etc.
    systems = [
      "x86_64-linux"
      # "aarch64-darwin"
    ];

    # This is a function that gnerates an attribute by calling a function you
    # pass to it, with each system as an argument.
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc.
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other optiosn besides 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = let
      system = "x86_64-linux";
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      sophie = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.djames = import ./home-manager/home.nix;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              firefox-addons-allowUnfree = unstablePkgs.callPackage firefox-addons {};
            };
          }
        ];
      };
    };
  };
}
