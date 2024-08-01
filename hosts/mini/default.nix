{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    ../common/audio.nix
    ../common/impermanence
    ../common/nix
    ../common/theme
    ../common/wayland
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true; # What does this do?
    };

    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "btrfs" ];
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "mini";
    networkmanager.enable = true;
  };

  programs.fish.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.harry = {
    initialPassword = "PepsiMax!";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
