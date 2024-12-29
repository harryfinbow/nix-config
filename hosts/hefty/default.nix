{ config, inputs, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Enable additional modules
  modules = {
    impermanence.enable = true;
    star-citizen.enable = true;
    steam.enable = true;
    gnome.enable = true;
  };

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

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  networking = {
    hostName = "hefty";
    networkmanager.enable = true;
  };

  programs.fish.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  security.polkit.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # users.users.harry = {
  #   initialPassword = "PepsiMax!";
  #   isNormalUser = true;
  #   extraGroups = [ "networkmanager" "wheel" "input" ];
  # };

  xdg.portal.enable = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

}
