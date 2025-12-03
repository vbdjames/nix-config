{
  inputs,
  self,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    (with self.nixosModules; [
      common
      bluetooth
      home
      locale
      sound
      systemd-boot
      user-icon
      x11
    ])

    "${self}/hosts/common/core"
    "${self}/users/djames/nixos.nix"

  ];

  networking = {
    hostName = "sophie";
  };

  home-manager.users.djames.imports = [
    "${self}/users/djames/home.nix"
  ];

  environment.systemPackages = with pkgs; [
    displaylink
    git
    sops
    vim
    wget
    kdePackages.qtmultimedia
    sddm-astronaut
  ];

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "djames" ];
  };

  environment.variables.EDITOR = "vim";

  # https://nixos.org/nixos/options.html
  system.stateVersion = "25.05";
}
