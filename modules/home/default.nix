{
  lib,
  inputs,
  pkgs,
  ...
}:
let
  homeModules = lib.listToAttrs (
    map
      (x: {
        name = lib.removeSuffix ".nix" (builtins.baseNameOf x);
        value = x;
      })
      [
        ./common.nix
      ]
  );
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      firefox-addons-allowUnfree = pkgs.callPackage inputs.firefox-addons { };
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    sharedModules = [
      homeModules.common
      inputs.plasma-manager.homeModules.plasma-manager
    ];
  };
}
