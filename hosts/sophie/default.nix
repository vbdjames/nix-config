{
  inputs,
  self,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ./sddm.nix
    (with self.nixosModules; [
      common
      avahi
      bluetooth
      home
      locale
      networking
      plasma6
      printing
      sound
      systemd-boot
      tailscale
      user-icon
      x11
    ])

    inputs.sops-nix.nixosModules.sops

    "${self}/users/djames"
  ];

  hardware.sane.enable = true;
  hardware.sane.drivers.scanSnap.enable = true;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

  system.stateVersion = "25.05"; # https://nixos.org/nixos/options.html
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "sophie";

  fonts = {
    packages = with pkgs; [
    fontconfig
    jetbrains-mono
  ];
  };

  environment.systemPackages = with pkgs; [
    displaylink
    git
    just
    vim
    wget
    nixd
    sops
    kdePackages.skanpage

  ];

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "djames" ];
  };

  programs.partition-manager.enable = true;

  environment.variables.EDITOR = "vim";

}
