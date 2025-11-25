{ lib, ... }:
let
  modules = lib.listToAttrs (
    map
      (x: {
        name = lib.removeSuffix ".nix" (builtins.baseNameOf x);
        value = x;
      })
      [
        ./bluetooth.nix
        ./common.nix
        ./locale.nix
        ./systemd-boot.nix
      ]
  );
in
{
  flake = {
    nixosModules = modules;
    profiles = {
      core = with modules; [
        common
      ];
      workstation = with modules; [
        bluetooth
        locale
        systemd-boot
      ];
    };
  };
}
