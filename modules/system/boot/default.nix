{
  flake.modules.nixos.default = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true; # What does this do?
      };

      initrd.supportedFilesystems = [ "btrfs" ];
    };
  };
}
