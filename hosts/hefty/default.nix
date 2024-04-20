# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, self, config, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/core
    ../common/hardware
    ../common/programs
    ../common/services
  ];

  # Networking
  networking.hostName = "hefty";

  # Uncategorised
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = [ "nvidia" ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
