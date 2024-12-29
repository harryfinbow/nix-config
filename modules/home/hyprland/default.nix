{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprpaper.nix
    ./settings.nix
  ];

  options.modules.hyprland = {
    enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    services.wlsunset = {
      enable = true;
      latitude = "51.51";
      longitude = "0.13";
      temperature = {
        day = 6500;
        night = 3000;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
