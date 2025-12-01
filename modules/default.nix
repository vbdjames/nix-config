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
        ./sound.nix
        ./systemd-boot.nix
        ./x11.nix
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
        sound
        systemd-boot
      ];
    };
  };
}
