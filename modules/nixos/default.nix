{ config, lib, ... }:

{
  imports = [
    ./audio
    ./docker
    ./firewall
    ./gnome
    ./hyprland
    ./impermanence
    ./nix
    ./star-citizen
    ./steam
    ./theme
    ./users
  ];

  modules = {
    audio.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    nix.enable = lib.mkDefault true;
    star-citizen.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
