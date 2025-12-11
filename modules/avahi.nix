{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    avahi
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

}