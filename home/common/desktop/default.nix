{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    inputs.zen-browser.packages."${system}".default
  ];
}
