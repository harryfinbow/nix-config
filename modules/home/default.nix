{ config, lib, ... }:

{
  imports = [
    ./alacritty
    ./desktop
    ./fish
    ./git
    ./hyprland
    ./impermanence
    ./neovim
    ./starship
    ./theme
    ./users
    ./utilities
    ./work
    ./zoxide
  ];

  modules = {
    alacritty.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    impermanence.enable = lib.mkDefault false;
    neovim.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
    utilities.enable = lib.mkDefault true;
    work.enable = lib.mkDefault false;
    zoxide.enable = lib.mkDefault true;
  };

  # Restart systemd
  systemd.user.startServices = "sd-switch";

  # Let `home-manager` manage itself
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
