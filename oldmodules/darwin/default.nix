{ lib, ... }:

{
  imports = [
    ./aerospace
    ./nix
    ./shells
    ./system
    ./theme
    ./users
  ];

  modules = {
    aerospace.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
  };

  system.stateVersion = 4;
}
