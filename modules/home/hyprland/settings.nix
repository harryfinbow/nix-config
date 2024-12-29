{ config, lib, ... }:

{
  config = lib.mkIf config.modules.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = "wl-paste -t text -w xclip -selection clipboard";

      bind = [
        # Main
        "SUPER SHIFT, Q, killactive"
        "SUPER, F, fullscreen, 1"
        "SUPER SHIFT, F, fullscreen, 0"
        "SUPER, V, togglefloating"
        "SUPER, V, resizeactive, exact 50% 50%"
        "SUPER, V, centerwindow"

        "ALT, TAB, cyclenext, prev"
        "ALT, TAB, bringactivetotop"

        # Programs
        "SUPER, Q, exec, alacritty"
        "SUPER, B, exec, zen"
        "SUPER, space, exec, rofi -show drun"

        # Workspaces
        "SUPER, 1, workspace,  1"
        "SUPER, 2, workspace,  2"
        "SUPER, 3, workspace,  3"
        "SUPER, 4, workspace,  4"
        "SUPER, 5, workspace,  5"
        "SUPER, 6, workspace,  6"
        "SUPER, 7, workspace,  7"
        "SUPER, 8, workspace,  8"
        "SUPER, 9, workspace,  9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace,  1"
        "SUPER SHIFT, 2, movetoworkspace,  2"
        "SUPER SHIFT, 3, movetoworkspace,  3"
        "SUPER SHIFT, 4, movetoworkspace,  4"
        "SUPER SHIFT, 5, movetoworkspace,  5"
        "SUPER SHIFT, 6, movetoworkspace,  6"
        "SUPER SHIFT, 7, movetoworkspace,  7"
        "SUPER SHIFT, 8, movetoworkspace,  8"
        "SUPER SHIFT, 9, movetoworkspace,  9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];


      decoration = {
        rounding = 10;
        active_opacity = 0.95;
        inactive_opacity = 0.95;
        fullscreen_opacity = 1;
      };

      general = {
        "col.active_border" = lib.mkForce "0xffffffff";
      };

      input = {
        sensitivity = 0;
        accel_profile = "flat";
      };

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "suppressevent fullscreen, class:.*"

        # Picture-in-picture
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];
    };
  };
}
