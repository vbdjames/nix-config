{
  config,
  pkgs,
  lib,
  inputs,
  firefox-addons-allowUnfree,
  ...
}:
{
  imports = [
    inputs._1password-shell-plugins.hmModules.default
  ];

  home.username = "djames";
  home.homeDirectory = "/home/djames";

  home.file = {
    ".background-image".source = (
      lib.custom.relativeToRoot "assets/astronaut.png"
    );
  };

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
    # enable 1Password shell plugins for bash, zsh, and fish shell
    enable = true;
    # the specified packages as well as 1Password CLI will be
    # automatically installed and configured to use shell plugins
    plugins = with pkgs; [ awscli2 ];
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
    ];
  };

  programs.firefox = {
    enable = true;
    profiles.djames = {
      extensions = with firefox-addons-allowUnfree; [
        onepassword-password-manager
      ];
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
      };
      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };

    };
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
