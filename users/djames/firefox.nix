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
        # TODO: how to add these?
        # id = support@todoist.com
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
      };
    };
  };
}
