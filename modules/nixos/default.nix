{ config, lib, ... }:

{
  imports = [
    ./audio
    ./boot
    ./docker
    ./firewall
    ./fish
    ./gnome
    ./hyprland
    ./impermanence
    ./logitech
    ./networking
    ./nix
    ./nvidia
    ./star-citizen
    ./steam
    ./theme
    ./users
  ];

  modules = {
    audio.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    logitech.enable = lib.mkDefault false;
    nix.enable = lib.mkDefault true;
    nvidia.enable = lib.mkDefault false;
    star-citizen.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}