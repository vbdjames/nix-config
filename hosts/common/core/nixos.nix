# Core functionality for every nixos host
{ config, lib, ... }:
{
  security.sudo.extraConfig = ''
    Defaults lecture = never
    Defaults pwfeedback
    Defaults timestamp_timeout=120
  '';

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 20d --keep 20";
    flake = "${config.hostSpec.home}/src/nix/nix-config";
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault config.hostSpec.timeZone;
}