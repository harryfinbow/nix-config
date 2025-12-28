{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.modules.hyprland.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && systemctl --user restart waybar.service"; # https://github.com/Alexays/Waybar/issues/3344
          }
        ];
      };
    };
  };
}
