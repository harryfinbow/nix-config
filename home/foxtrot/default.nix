{
  # Enable additional modules
  modules = {
    impermanence.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1, 1920x1080@60, 0x0, 1";
    general = {
      gaps_in = 5;
      gaps_out = 10;
    };
  };
}
