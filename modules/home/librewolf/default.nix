{ config, lib, ... }:

{
  options.modules.librewolf = {
    enable = lib.mkEnableOption "enables librewolf";
  };

  config = lib.mkIf config.modules.librewolf.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        # Enable WebGL, cookies and history
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown_v2.history" = false;
        "privacy.clearOnShutdown_v2.cookies" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;

        # UI
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always-show";
        "sidebar.main.tools" = "bookmarks";

      };
    };
  };
}
