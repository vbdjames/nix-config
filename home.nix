{ config, pkgs, ... }:

{
  home.username = "djames";
  home.homeDirectory = "/home/djames";

  home.packages = with pkgs; [
    neofetch
  ];

  home.stateVersion = "25.05";
}
