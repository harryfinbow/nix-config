{ lib, ... }:

{
  imports = [
    ./actual
    ./audio
    ./boot
    ./caddy
    ./firewall
    ./fish
    ./glance
    ./gnome
    ./grafana
    ./home-assistant
    ./hyprland
    ./impermanence
    ./intel
    ./linkding
    ./logitech
    ./mealie
    ./networking
    ./nix
    ./nixarr
    ./nvidia
    ./orcaslicer
    ./prometheus
    ./star-citizen
    ./steam
    ./theme
    ./users
    ./uptime-kuma
    ./vintagestory
    ./virtualisation
    ./vms/minecraft-server
    ./vms
  ];

  modules = {
    actual.enable = lib.mkDefault false;
    audio.enable = lib.mkDefault true;
    boot.enable = lib.mkDefault true;
    caddy.enable = lib.mkDefault false;
    firewall.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    glance.enable = lib.mkDefault false;
    gnome.enable = lib.mkDefault false;
    grafana.enable = lib.mkDefault false;
    home-assistant.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    intel.enable = lib.mkDefault false;
    linkding.enable = lib.mkDefault false;
    logitech.enable = lib.mkDefault false;
    mealie.enable = lib.mkDefault false;
    networking.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    nixarr.enable = lib.mkDefault false;
    nvidia.enable = lib.mkDefault false;
    orcaslicer.enable = lib.mkDefault false;
    prometheus.enable = lib.mkDefault false;
    star-citizen.enable = lib.mkDefault false;
    steam.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
    uptime-kuma.enable = lib.mkDefault false;
    vintagestory.enable = lib.mkDefault false;
    virtualisation.enable = lib.mkDefault true;
    vm.minecraft-server.enable = lib.mkDefault false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
