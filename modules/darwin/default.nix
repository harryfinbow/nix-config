{ config, lib, ... }:

{
  imports = [
    ./nix
    ./shells
    ./system
    ./theme
    ./users
    ./yabai
  ];

  modules = {
    nix.enable = lib.mkDefault true;
    yabai.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
