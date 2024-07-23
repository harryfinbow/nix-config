{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
  ];

  programs.firefox.enable = true;
}
