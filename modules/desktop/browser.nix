{
  flake.modules.homeManager.desktop =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      config = {
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
            "browser.startup.page" = 3; # Restore previous sessions on startup
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
            "sidebar.visibility" = "always-show";
            "sidebar.main.tools" = "bookmarks";

          };
        };

        home = lib.optionalAttrs (options.home ? persistence) {
          persistence."/persist".directories = [
            ".librewolf"
            ".mozilla"
            ".zen" # TODO: Remove this at some point
          ];
        };

        # https://github.com/adriankarlen/textfox/pull/120
        # textfox = {
        #   enable = true;
        #   profile = "default";
        # };
      }
      // lib.optionalAttrs (options ? stylix) {
        stylix.targets.librewolf.profileNames = [ "default" ];
      };
    };
}
