{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.modules.hyprland.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${./wallpapers/snowy.png}" ];
        wallpaper = [ ",${./wallpapers/snowy.png}" ];
      };
    };
  };
}
