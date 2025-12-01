{
  lib,
  inputs,
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
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    sharedModules = [
      homeModules.common
    ];
  };
}
