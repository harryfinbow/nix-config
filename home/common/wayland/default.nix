{ pkgs, ... }:

{
  imports = [ ./hyprland.nix ./hyprpaper.nix ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  services.wlsunset = {
    enable = true;
    latitude = "51.51";
    longitude = "0.13";
  };

  # Gamescope Fix???
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    #SDL_VIDEODRIVER = "x11";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
