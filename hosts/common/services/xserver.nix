{
  services.xserver.enable = true;

  # Allow gdm to run on Wayland.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
}
