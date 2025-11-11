{
  description = "vbdjames's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    # nixpkgs-unstable,
    # home-manager,
    # firefox-addons,
    ...
  } @ inputs: let
    inherit (self) outputs;

    #
    # ====== Architectures ======
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      # "aarch64-darwin"
    ];

    # ====== Extend lib with lib.custom ======
    # NOTE: This approach allows lib.custom to propagate into hm
    # see: https://github.com/nix-community/home-manager/pull/3454
    lib = nixpkgs.lib.extend (self: super: {custom = import ./lib {inherit (nixpkgs) lib;};});
  in {
    #
    # ====== Overlays ======
    #
    # Custom modifications/overrides to upstream packages
    overlays = import ./overlays {inherit inputs;};

    #
    # ====== Host Configurations ======
    # Building configurations is available through `just rebuild` or `nixos-rebuild --flake .#hostname`
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specalArgs = {
            inherit inputs outputs lib;
            isDarwin = false;
          };
          modules = [./hosts/nixos/${host}];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
    );

    darwinConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = nix-darwin.lib.darwinSystsem {
          specialArgs = {
            inherit inputs outputs lib;
            isDarwin = true;
          };
          modules = [.hosts/darwin/${host}];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts/darwin))
    );

    #
    # ====== Packages ======
    #
    # Expose custom packages
    /*
    NOTE: This is only for exposing packages externally; ie, `nix build .#packages.x86_64-linux.cd-gitroot`
    For internal use, these packages are added through the default overlay in `overlays/default.nix
    */
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
      in
        nixpkgs.lib.packagesFromDirectoryRecursive {
          callPackage = nixpkgs.lib.callPackageWith pkgs;
          directory = ./pkgs/common;
        }
    );

    #
    # ====== Formatting ======
    #
    # Nix formatter available through 'nix fmt' https://github.com/NixOS/nixfmt
    # Other optiosn besides 'alejandra' include 'nixpkgs-fmt' and 'nixfmt-rfc-style'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # nixosConfigurations = let
    #   system = "x86_64-linux";
    #   unstablePkgs = import nixpkgs-unstable {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };
    # in {
    #   sophie = nixpkgs.lib.nixosSystem {
    #     modules = [
    #       ./nixos/configuration.nix
    #       home-manager.nixosModules.home-manager
    #       {
    #         home-manager.useGlobalPkgs = true;
    #         home-manager.useUserPackages = true;
    #         home-manager.users.djames = import ./home-manager/home.nix;
    #         home-manager.backupFileExtension = "backup";
    #         home-manager.extraSpecialArgs = {
    #           inherit inputs;
    #           firefox-addons-allowUnfree = unstablePkgs.callPackage firefox-addons {};
    #         };
    #       }
    #     ];
    #   };
    # };
  };
}
