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
        preload = [ "${./wallpapers/cityscape-nord.png}" ];
        wallpaper = [ ",${./wallpapers/cityscape-nord.png}" ];
      };
    };
  };
}
