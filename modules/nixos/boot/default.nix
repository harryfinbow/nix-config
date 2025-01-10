{
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
}
