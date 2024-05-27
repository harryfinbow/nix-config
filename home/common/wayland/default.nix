{ pkgs, ... }:

{
  imports = [ ./hyprland.nix ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  services.wlsunset = {
    enable = true;
    latitude = "51.51";
    longitude = "0.13";
  };
}
