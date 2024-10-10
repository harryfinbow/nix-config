{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    inputs.zen-browser.packages.x86_64-linux.zen-browser
  ];
}
