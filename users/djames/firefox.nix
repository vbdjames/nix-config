{
  firefox-addons-allowUnfree,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.djames = {
      extensions.packages = [
        firefox-addons-allowUnfree.onepassword-password-manager
        # todoist
        # id = support@todoist.com

        # obsidian web clipper
        # id = clipper@obsidian.md
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
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "NixOS Options";
                url = "https://search.nixos.org/options";
              }
              {
                name = "Home Manager Options";
                url = "https://home-manager-options.extranix.com";
              }
            ];
          }
        ];
      };
    };
  };
}
