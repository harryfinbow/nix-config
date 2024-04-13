# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, self, ... }:

{
  imports = let 
    mod = "${self}/system"; 
  in [
    ./hardware-configuration.nix

    ${mod}/core
    ${mod}/programs/fish.nix
    ${mod}/programs/fonts.nix
    ${mod}/programs/hyprland.nix
    ${mod}/programs/nix.nix
  ];

  # Networking
  networking.hostName = "nixos";

  # Uncategorised
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
