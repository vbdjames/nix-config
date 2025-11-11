################################
#
#  Sophie - main personal laptop
#  NixOS running on HP 840g8
#
################################
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "hosts/common/core"
      "hosts/common/optional/services/bluetooth.nix"
      "hosts/common/optional/services/printing.nix"
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/obsidian.nix"
    ])
  ];

  hostSpec = {
    hostName = "sophie";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
