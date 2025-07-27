{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.gnome = {
    enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.modules.gnome.enable {
    services = {
      # Enable X11 compatible desktop
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
