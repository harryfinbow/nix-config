# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    MNTPOINT=$(mktemp -d)
    mount /dev/disk/by-partlabel/disk-main-root $MNTPOINT -o subvol=/

    trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT

    # Recursively delete child subvolumes (as `btrfs subvolume delete` doesn't)
    btrfs subvolume list -o $MNTPOINT/rootfs |
    cut -f9 -d' ' |
    while read SUBVOLUME; do
      echo "deleting $SUBVOLUME..."
      btrfs subvolume delete "$MNTPOINT/$SUBVOLUME"
    done

    echo "deleting $MNTPOINT/rootfs..."
    btrfs subvolume delete $MNTPOINT/rootfs

    echo "creating snapshot..."
    btrfs subvolume snapshot $MNTPOINT/rootfs@blank $MNTPOINT/rootfs
  '';

  # systemd.tmpfiles.rules = [
  #   "d /persist/system 0777 root root -"
  #   "d /persist/home 0777 root root -"
  #   "d /persist/home/harry 0700 harry users -"
  # ];

  # fileSystems."/persist".neededForBoot = true;
  # environment.persistence."/persist/system" = {
  #   hideMounts = true;
  #   directories = [
  #     "/var/log"
  #     "/var/lib/alsa"
  #     "/var/lib/bluetooth"
  #     "/var/lib/nixos"
  #     "/var/lib/systemd/coredump"
  #     "/etc/NetworkManager/system-connections"
  #     { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
  #   ];
  #   files = [
  #     "/etc/machine-id"
  #     { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
  #   ];
  # };

  # programs.fuse.userAllowOther = true;
  # home-manager = {
  #   extraSpecialArgs = {inherit inputs;};
  #   users = {
  #     "harry" = import ./home.nix;
  #   };
  # };

  nixpkgs.config.allowUnfree = true;

  # Nvidia
  # environment.sessionVariables = {
  #   WLR_NO_HARDWARE_CURSORS = "1";
  #   NIXOS_OZONE_WL = "1";
  # };

  # services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.beta;
  # };

  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  # };


  # Star Citizen
  # nix.settings = {
  #   substituters = [
  #     "https://nix-gaming.cachix.org"
  #     "https://nix-citizen.cachix.org"
  #   ];
  #   trusted-public-keys = [
  #     "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
  #     "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
  #   ];
  # };

  # nix-citizen.starCitizen = {
  #   # Enables the star citizen module
  #   enable = true;
  #   # Additional commands before the game starts
  #   preCommands = ''
  #       export DXVK_HUD=compiler;
  #       export MANGO_HUD=1;
  #   '';
  #   # Experimental script
  #   helperScript.enable = true;
  # };

  # swapDevices = [{
  #   device = "/swapfile";
  #   size = 64 * 1024; # 24GB
  # }];

  # zramSwap = {
  #   enable = true;
  #   memoryPercent = 100;
  # };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.harry = {
    isNormalUser = true;
    initialPassword = "123456";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
  #    inputs.nix-citizen.packages.${system}.lug-helper
      mangohud
      firefox
      neovim
      tree
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

