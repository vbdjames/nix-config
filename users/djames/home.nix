{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs._1password-shell-plugins.hmModules.default
    ./firefox.nix
  ];

  home.username = "djames";
  home.homeDirectory = "/home/djames";

  home.file.".background-image".source = "${inputs.self}/assets/astronaut.png";

  home.packages = with pkgs; [
    ansible
    awscli2
    neofetch
    obsidian
    opentofu
    todoist-electron
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "/home/${config.home.username}/.background-image";
    };
    session.general.askForConfirmationOnLogout = false;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      scrolling = {
        history = 100000;
      };
    };
  };

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

  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [ awscli2 ];
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
    ];
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
        "getantidote/use-omz" # handle OMZ dependencies
        "ohmyzsh/ohmyzsh path:lib" # load OMZ's library
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/opentofu"
        "zsh-users/zsh-syntax-highlighting"
        "MichaelAquilina/zsh-you-should-use"
        "fdellwing/zsh-bat"
        "sparsick/ansible-zsh"
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
