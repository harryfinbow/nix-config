{ lib, ... }:

{
  imports = [
    ./actual
    ./audio
    ./boot
    ./caddy
    ./ddclient
    ./firewall
    ./fish
    ./glance
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
    ./vintagestory
    ./virtualisation
    ./vms/minecraft-server
  ];

  modules = {
    actual.enable = lib.mkDefault false;
    audio.enable = lib.mkDefault true;
    boot.enable = lib.mkDefault true;
    caddy.enable = lib.mkDefault false;
    ddclient.enable = lib.mkDefault false;
    firewall.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    glance.enable = lib.mkDefault false;
    gnome.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    logitech.enable = lib.mkDefault false;
    networking.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    nvidia.enable = lib.mkDefault false;
    star-citizen.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
    vintagestory.enable = lib.mkDefault false;
    virtualisation.enable = lib.mkDefault true;
    vm.minecraft-server.enable = lib.mkDefault false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
