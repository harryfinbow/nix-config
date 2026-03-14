{
  flake.modules.nixos.wayland = {
    services.displayManager.ly = {
      enable = true;
    };

    # https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
    # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
    # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
