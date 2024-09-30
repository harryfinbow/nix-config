{ pkgs, ... }:

{
  imports = [ ./hyprland.nix ./hyprpaper.nix ];

  home.packages = with pkgs; [
    wl-clipboard
    xclip
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
}
