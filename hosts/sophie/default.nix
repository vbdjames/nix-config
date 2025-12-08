{
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

    "${self}/users/djames"
  ];

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
  ];

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "djames" ];
  };

  environment.variables.EDITOR = "vim";

}
