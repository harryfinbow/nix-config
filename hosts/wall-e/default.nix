# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../system/core
    ../../system/hardware
    ../../system/programs
    ../../system/services
  ];

  # Networking
  networking.hostName = "wall-e";

  # Uncategorised
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
