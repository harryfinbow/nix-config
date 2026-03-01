{ lib, config, ... }:

{
  options.modules.boot = {
    enable = lib.mkEnableOption "enables boot";
  };

  config = lib.mkIf config.modules.boot.enable {
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
  };
}
