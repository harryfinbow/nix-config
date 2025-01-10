{ config, pkgs, lib, ... }:

{
  options.modules.utilities = {
    enable = lib.mkEnableOption "enables utilities";
  };

  config = lib.mkIf config.modules.utilities.enable {
    home.packages = with pkgs; [
      # System
      neofetch
      btop
      alsa-utils

      # Utilities
      jq
      eza
      psmisc
    ];
  };
}
