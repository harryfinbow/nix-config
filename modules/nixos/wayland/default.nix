{ inputs, pkgs, lib, config, ... }:

{
  options.desktop = {
    enable = lib.mkEnableOption "enables desktop";
  };

  config = lib.mkIf config.desktop.enable {
    config.hyprland.enable = lib.mkDefault true;
    config.gnome.enable = lib.mkDefault false;
  };
}
