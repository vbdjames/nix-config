{
  description = "vbdjames's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      firefox-addons,
      ...
    }:
    let
      inherit (self) outputs;
      # Supported systems for flake packages, shell, etc.
      systems = [
        "x86_64-linux"
        # "aarch64-darwin"
      ];

      # This is a function that gnerates an attribute by calling a function you
      # pass to it, with each system as an argument.
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      
      nixosConfigurations =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
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
                  firefox-addons-allowUnfree = pkgs.callPackage firefox-addons { };
                };
              }
            ];
          };
        };
      
      # Formatter for your nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
