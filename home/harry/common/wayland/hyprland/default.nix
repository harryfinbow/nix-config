{ inputs, ... }:

{
  imports =
    [ inputs.hyprland.homeManagerModules.default ./binds.nix ./settings.nix ];

  wayland.windowManager.hyprland.enable = true;
}
