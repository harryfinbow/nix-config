{ pkgs, ... }:

{
  imports = [ ./firefox.nix ./rofi.nix ];

  home.packages = with pkgs; [ spotify ];
}
