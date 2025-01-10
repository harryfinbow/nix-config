{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Enable additional modules
  modules = {
    impermanence.enable = true;
    star-citizen.enable = true;
    steam.enable = true;
    gnome.enable = true;
  };

  # TODO: Why did I add this?
  security.polkit.enable = true;
}
