{
  flake.modules.nixos.desktop = {
    programs.hyprland.enable = true;

    # Fix missing cursor on Hyprland
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    # https://github.com/cachix/cachix/issues/323
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    services.displayManager.defaultSession = "hyprland";
  };
}
