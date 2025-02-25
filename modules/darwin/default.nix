{ lib, ... }:

{
  imports = [
    ./aerospace
    ./nix
    ./shells
    ./system
    ./theme
    ./users
    ./yabai
  ];

  modules = {
    aerospace.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    yabai.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
  };

  system.stateVersion = 4;
}
