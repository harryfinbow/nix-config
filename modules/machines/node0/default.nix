{ config, ... }:

{
  flake.modules.nixos.node0 = {
    imports = with config.flake.modules.nixos; [
      default
      desktop
      terminal
      impermanence

      # Services
      # actual
      # caddy
      # glance
      # grafana
      # home-assistant
      # linkding
      # nixarr
      # prometheus

      # https://github.com/NixOS/nixpkgs/issues/494075
      # mealie
    ];

    networking.networkmanager.enable = true;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
  };

  flake.modules.homeManager.node0 = {
    imports = with config.flake.modules.homeManager; [
      desktop
      games
      terminal
      impermanence

      # Applications
      discord
      orcaslicer
    ];

    wayland.windowManager.hyprland.settings = {
      monitor = "eDP-1, 1920x1080@60, 0x0, 1";
      general = {
        gaps_in = 5;
        gaps_out = 10;
      };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
