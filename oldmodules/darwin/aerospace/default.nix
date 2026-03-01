{ lib, config, ... }:

{

  options.modules.aerospace = {
    enable = lib.mkEnableOption "enables aerospace";
  };

  config = lib.mkIf config.modules.aerospace.enable {
    services.aerospace = {

      enable = true;
      settings = {
        gaps = {
          inner.horizontal = 8;
          inner.vertical = 8;
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 8;
          outer.right = 8;
        };
        mode.main.binding = {
          # See: https://nikitabobko.github.io/AeroSpace/commands#layout
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          # See: https://nikitabobko.github.io/AeroSpace/commands#focus
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          # See: https://nikitabobko.github.io/AeroSpace/commands#move
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
          alt-0 = "workspace 0";
          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";

          alt-n = "workspace n"; # Notes
          alt-z = "workspace z"; # Zoom

          # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
          alt-shift-0 = "move-node-to-workspace 0";
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";

          alt-shift-n = "move-node-to-workspace n"; # Notes
          alt-shift-z = "move-node-to-workspace z"; # Zoom

          alt-shift-f = "fullscreen";

          alt-v = "layout floating tiling";

          # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
          alt-tab = "workspace-back-and-forth";
          # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
          alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        };

        on-window-detected = [
          {
            "if".app-id = "com.apple.finder";
            run = [ "layout floating" ];
          }
          {
            "if".app-id = "com.kagi.kagimacOS";
            run = [ "move-node-to-workspace 1" ];
          }
          {
            "if".app-id = "us.zoom.xos";
            run = [ "move-node-to-workspace z" ];
          }
        ];
      };
    };
  };
}
