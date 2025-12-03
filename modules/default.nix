{ lib, ... }:
let
  modules = lib.listToAttrs (
    map
      (x: {
        name = lib.removeSuffix ".nix" (builtins.baseNameOf x);
        value = x;
      })
      [
        ./home
        ./bluetooth.nix
        ./common.nix
        ./locale.nix
        ./sound.nix
        ./systemd-boot.nix
        ./user-icon.nix
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
        home
        locale
        sound
        systemd-boot
      ];
    };
  };
}
