{ pkgs, ... }:

{
  imports = [ ./theme.nix ./hyprland ./waybar.nix ./wlsunset.nix ];

  home.packages = with pkgs; [ wl-clipboard ];
}
