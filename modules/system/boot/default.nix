{
  flake.modules.nixos.default = {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true; # What does this do?
      };

      initrd.supportedFilesystems = [ "btrfs" ];

      # Don't treat FN keys as multi-media keys
      extraModprobeConfig = ''
        options hid_apple fnmode=0
      '';
    };
  };
}
