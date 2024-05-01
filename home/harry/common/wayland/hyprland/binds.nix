{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      # Main
      "$mod SHIFT, Q, killactive"
      "$mod, F, fullscreen"
      "$mod, V, togglefloating"

      # Programs
      "$mod, Q, exec, alacritty"
      "$mod, B, exec, firefox"
      "$mod, space, exec, rofi -show drun"
    ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]) 10));
  };
}
