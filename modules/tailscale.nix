{ pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    port = 41641;
  };

  networking.firewall.allowedUDPPorts = [ 41641 ];

  environment.systemPackages = with pkgs; [
    tailscale
  ];
}