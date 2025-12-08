{
  inputs,
  self,
  config,
  pkgs,
  lib,
  ...
}:
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      Background = "${self}/assets/pexels-kellie-churchman-371878-1001682.png";
    };
  };
in
{
  imports = lib.flatten [
    ./hardware-configuration.nix
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

  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    displaylink
    git
    just
    vim
    wget
    kdePackages.qtmultimedia
    custom-sddm-astronaut
  ];

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "djames" ];
  };

  environment.variables.EDITOR = "vim";

}
