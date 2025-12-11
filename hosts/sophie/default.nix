{
  inputs,
  self,
  pkgs,
  lib,
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
      user-icon
      x11
    ])

    inputs.sops-nix.nixosModules.sops

    "${self}/users/djames"
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

  system.stateVersion = "25.05"; # https://nixos.org/nixos/options.html
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "sophie";

  environment.systemPackages = with pkgs; [
    displaylink
    git
    just
    vim
    wget
    nixd
    sops
  ];

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "djames" ];
  };

  environment.variables.EDITOR = "vim";

}
