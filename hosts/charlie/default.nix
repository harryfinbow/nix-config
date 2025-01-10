{ modulesPath, lib, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Configure modules
  modules = {
    audio.enable = false;
    hyprland.enable = false;
  };

  services.openssh.enable = true;

  virtualisation.vmware.guest.enable = true;

}
