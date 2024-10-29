{ config, lib, ... }:

{
  imports = [
    ./audio
    ./docker
    ./firewall
    ./impermanence
    ./nix
    ./star-citizen
    ./steam
    ./theme
    ./users
    ./wayland
  ];

  modules = {
    audio.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    nix.enable = lib.mkDefault true;
    star-citizen.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
    users.enable = lib.mkDefault true;
    wayland.enable = lib.mkDefault true;
  };

}
