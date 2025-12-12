{
  pkgs,
  self,
  inputs,
  ...
}:
{
  users.users.djames = {
    isNormalUser = true;
    icon = "${self}/assets/djames.png";
    description = "Doug James";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager.users.djames = {
    imports = [
      inputs._1password-shell-plugins.hmModules.default
      ./firefox.nix
      ./thunderbird.nix
    ];

    home.username = "djames";
    home.homeDirectory = "/home/djames";

    home.file.".background-image".source = "${self}/assets/pexels-kellie-churchman-371878-1001682.png";

    home.file.".aws/config".text = ''
      [default]
    '';

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
        wallpaper = "/home/djames/.background-image";
      };
      session.general.askForConfirmationOnLogout = false;
      kwin = {
        nightLight = {
          enable = true;
          mode = "location";
          location = { # Chesapeake, VA
            latitude = "36.7682";
            longitude = "-76.2875";
          };
          transitionTime = 30;
        };
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        scrolling = {
          history = 100000;
        };
      };
    };

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
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };

    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        jnoortheen.nix-ide
      ];
    };

  };
}
