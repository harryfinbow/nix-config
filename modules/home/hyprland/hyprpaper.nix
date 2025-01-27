{ config, inputs, lib, ... }:

{
  config = lib.mkIf config.modules.hyprland.enable {
    age.secrets.wallpaper.file = ../../../secrets/wallpaper.age;

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${config.age.secrets.wallpaper.path}" ];
        wallpaper = [ ",${config.age.secrets.wallpaper.path}" ];
      };
    };
  };
}
