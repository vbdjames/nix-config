# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
# Help is available in the configuration.nix(5) man page and in the NixOS manual
# (accessible by running ‘nixos-help’)
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
    (with self.profiles; [
      core
      workstation
    ])

    "${self}/hosts/common/core"
    "${self}/hosts/common/core/icon.nix"
    "${self}/users/djames/nixos.nix"

  ];

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.FastConnectable = true;
  hardware.bluetooth.settings.Policy.AutoEnable = true;

  networking.hostName = "sophie";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "displaylink" ];
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

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
