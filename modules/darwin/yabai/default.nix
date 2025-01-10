{ lib, config, ... }:

{

  options.modules.yabai = {
    enable = lib.mkEnableOption "enables yabai";
  };

  config = lib.mkIf config.modules.yabai.enable {
    services.yabai = {
      enable = true;
      config = {
        mouse_modifier = "cmd";
        mouse_action1 = "move";
        mouse_action2 = "resize";

        layout = "bsp";
        top_padding = 10;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
      };
    };
  };
}
