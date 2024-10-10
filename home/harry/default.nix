{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../common
    ../common/desktop
    ../common/impermanence
    ../common/theme
    ../common/wayland
    ../common/terminal.nix
  ];

  gtk.enable = true;

  home = {
    username = "harry";
    homeDirectory = "/home/harry";

    packages = with pkgs; [
      # Desktop
      spotify
      vesktop

      # System
      neofetch
      btop
      alsa-utils

      # Utilities
      jq
      eza
      psmisc

      # Games
      inputs.nix-citizen.packages.${pkgs.system}.star-citizen
      inputs.nix-citizen.packages.${pkgs.system}.lug-helper
      runelite
    ];
  };

  # Restart systemd
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
