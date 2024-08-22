{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix

    ../common/audio.nix
    ../common/docker
    ../common/impermanence
    ../common/nix
    ../common/star-citizen
    ../common/steam
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
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "hefty";
    networkmanager.enable = true;
  };

  programs.fish.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

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
