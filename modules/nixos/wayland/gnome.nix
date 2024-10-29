{ inputs, pkgs, ... }:

{
  options.gnome = {
    enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services = {
      xserver = {
        enable = true;
        # Enable X11 compatible desktop
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  }
