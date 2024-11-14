{ inputs, pkgs, lib, config, ... }:

{
  imports = [ ./hyprland.nix ./gnome.nix ];
  options.modules.desktop = {
    enable = lib.mkEnableOption "enables desktop";
  };

  config = lib.mkIf config.modules.desktop.enable {
    modules.hyprland.enable = lib.mkDefault true;
    modules.gnome.enable = lib.mkDefault false;
  };
}
