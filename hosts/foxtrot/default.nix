{
  inputs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.dell-latitude-7490
  ];

  # Enable additional modules
  modules = {
    impermanence.enable = true;
  };

  # https://wiki.archlinux.org/title/Intel_graphics#Crash/freeze_on_low_power_Intel_CPUs
  boot.kernelParams = [
    "i915.enable_dc=0"
  ];
}
