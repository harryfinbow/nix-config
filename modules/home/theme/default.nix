{ config, lib, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.modules.theme.enable {
    gtk.enable = true;

    stylix = {
      targets.hyprpaper.enable = lib.mkForce false;
    };
  };
}
