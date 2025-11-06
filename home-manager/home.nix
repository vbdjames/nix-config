{ config, pkgs, ... }:

{
  home.username = "djames";
  home.homeDirectory = "/home/djames";

  home.packages = with pkgs; [
    neofetch
    thunderbird
    obsidian
  ];

  home.stateVersion = "25.05";

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
    ];
  };
}
