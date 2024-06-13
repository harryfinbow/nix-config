{ config, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/audio.nix
    ../common/wayland
    ../common/games
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
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true; # Required to change default shell

  services.xserver.videoDrivers = [ "nvidia" ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    fonts = {
      serif = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Serif";
      };
      sansSerif = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Sans";
      };
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Mono";
      };
    };

    # https://github.com/danth/stylix/issues/200
    image = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png";
      sha256 = "028bgjzr4q5yhdd4i6ypvk6ch4jjs5qz34ag8b4wcpr835mc37by";
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.harry = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
