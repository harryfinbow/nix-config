topLevel: {
  flake.modules.homeManager.desktop =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      config = {
        services.hyprpaper = {
          enable = true;
          settings = {
            preload = [ "${./wallpapers/snowy.png}" ];
            wallpaper = [ ",${./wallpapers/snowy.png}" ];
          };
        };
      }
      // lib.optionalAttrs (options ? stylix) {
        stylix.targets.hyprpaper.enable = lib.mkForce false;
      };
    };
}
