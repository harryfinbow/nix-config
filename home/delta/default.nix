{ config, ... }:

{
  # Configure modules
  modules = {
    desktop.enable = false;
    hyprland.enable = false;
    zellij.remote = true;
  };
}
