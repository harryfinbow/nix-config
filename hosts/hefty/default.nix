# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ config, inputs, pkgs, self, pkgs-small, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/core
    ../common/hardware
    ../common/programs
    ../common/programs/hyprland.nix
    ../common/programs/theme.nix
    ../common/services
  ];

  # Need to wrap everything in 'config' to override kernelPackages
  # config = {
  # Networking
  networking.hostName = "hefty";

  # NVIDIA
  # Until https://github.com/NixOS/nixpkgs/pull/313440 is on unstable
  # boot.kernelPackages = inputs.nixpkgs-small.legacyPackages.${pkgs.system}.linuxPackages;
  # boot.kernelPackages = pkgs-small.legacyPackages.${pkgs.system}.linuxPackages;
  boot.kernelPackages = pkgs-small.linuxPackages;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
