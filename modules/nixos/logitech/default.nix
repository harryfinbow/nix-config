{ lib, config, ... }:

{
  options.modules.logitech = {
    enable = lib.mkEnableOption "enables logitech";
  };

  config = lib.mkIf config.modules.logitech.enable {

    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
