{ inputs, config, pkgs, ... }:

{
  home.username = "djames";
  home.homeDirectory = "/home/djames";

  home.packages = with pkgs; [
    awscli2
    neofetch
    obsidian
  ];

  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };

  accounts.email.accounts = {
    "doug@dwjames.org" = {
      primary = true;
      address = "doug@dwjames.org";
      flavor = "fastmail.com";
      imap.host = "imap.fastmail.com";
      realName = "Doug James";
      smtp.host = "smtp.fastmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
      userName = "doug@dwjames.org";
    };
    "vbdjames@gmail.com" = {
      address = "vbdjames@gmail.com";
      flavor = "gmail.com";
      imap.host = "imap.gmail.com";
      imap.port = 993;
      realName = "Doug James";
      smtp.host = "smtp.gmail.com";
      smtp.port = 465;
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
    "doug.james@customviewbook.com" = {
      address = "doug.james@customviewbook.com";
      flavor = "gmail.com";
      imap.host = "imap.gmail.com";
      imap.port = 993;
      realName = "Doug James";
      smtp.host = "smtp.gmail.com";
      smtp.port = 465;
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };

  home.stateVersion = "25.05";

  home.file.".aws/config".text = ''
    [default]
  '';

  imports = [ inputs._1password-shell-plugins.hmModules.default ];
  programs._1password-shell-plugins = {
    # enable 1Password shell plugins for bash, zsh, and fish shell
    enable = true;
    # the specified packages as well as 1Password CLI will be
    # automatically installed and configured to use shell plugins
    plugins = with pkgs; [ awscli2 ];
  };

  programs.zsh = {
    enable = true;
    history = {
      save = 100000;
      size = 100000;
      append = true;
    };
    historySubstringSearch.enable = true;
    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz"        # handle OMZ dependencies
        "ohmyzsh/ohmyzsh path:lib"   # load OMZ's library
        "ohmyzsh/ohmyzsh path:plugins/git"
        "zsh-users/zsh-syntax-highlighting"
        "MichaelAquilina/zsh-you-should-use"
        "fdellwing/zsh-bat"
      ];
    };
  };

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
