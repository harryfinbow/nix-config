{ inputs, pkgs, lib, config, ... }:

{
  options.modules.desktop = {
    enable = lib.mkEnableOption "enables desktop";
  };

  config = lib.mkIf config.modules.modules.desktop.enable {
    imports = [ ./hyprland.nix ./gnome.nix ];
    modules.hyprland.enable = lib.mkDefault true;
    modules.gnome.enable = lib.mkDefault false;
  };
}
