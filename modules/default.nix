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
        ./avahi.nix
        ./bluetooth.nix
        ./common.nix
        ./locale.nix
        ./networking.nix
        ./plasma6.nix
        ./printing.nix
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
