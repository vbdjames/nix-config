{
  pkgs,
  config,
  lib,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "displaylink" ];
      xkb = {
        layout = "us";
      };
    };
  };
}
