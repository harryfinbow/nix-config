{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/audio.nix
    ../common/wayland
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true; # What does this do?
    };

    # https://github.com/starcitizen-lug/knowledge-base/wiki/Tips-and-Tricks#configuration-differences-required-for-nixos
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
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

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;

    # nix-gaming
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true; # Required to change default shell

  services.xserver.videoDrivers = [ "nvidia" ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    # https://github.com/danth/stylix/issues/200
    image = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png";
      sha256 = "028bgjzr4q5yhdd4i6ypvk6ch4jjs5qz34ag8b4wcpr835mc37by";
    };
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 24 * 1024;
  }];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.harry = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [ firefox ];
    shell = pkgs.fish;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
