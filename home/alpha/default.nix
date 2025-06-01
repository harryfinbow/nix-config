{ config, inputs, lib, pkgs, ... }:

{
  # Enable additional modules
  modules = {
    impermanence.enable = true;
  };


  home = {
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
      runelite
    ];
  };
}
