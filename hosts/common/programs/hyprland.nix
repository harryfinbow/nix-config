{
  programs.hyprland.enable = true;

  # Fix missing cursor
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
}
