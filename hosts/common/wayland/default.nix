{
  # Fix missing cursor on Hyprland
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.hyprland.enable = true;

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };
}
