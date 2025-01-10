{ config, lib, ... }:

{
  imports = [
    ./nix
    ./shells
    ./system
    ./users
    ./yabai
  ];

  modules = {
    nix.enable = lib.mkDefault true;
    yabai.enable = lib.mkDefault true;
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
