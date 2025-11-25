{ lib, ... }:
let
  modules = lib.listToAttrs (
    map (x: {
      name = lib.removeSuffix ".nix" (builtins.baseNameOf x);
      value = x;
    }) 
    [
      ./common.nix
      ./locale.nix
      ./systemd-boot.nix
      ./bluetooth.nix
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
        locale
        systemd-boot
        bluetooth
      ];
    };
  };
}