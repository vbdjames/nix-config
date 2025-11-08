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

  home.shellAliases = {
    ga="git add";
    gcmsg="git commit -m";
    gco="git checkout";
    gd="git diff";
    gst="git status";
    gvb="git checkout -b";
  };

  programs.zsh.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
    ];
  };
}
