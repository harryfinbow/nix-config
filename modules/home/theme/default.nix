{ config, lib, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.modules.theme.enable {
    stylix = {
      targets.hyprpaper.enable = lib.mkForce false;
    };
  };
}
