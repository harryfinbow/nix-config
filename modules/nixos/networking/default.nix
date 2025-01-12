{ lib, config, currentSystemName, ... }:

{
  options.modules.networking = {
    enable = lib.mkEnableOption "enables networking";
  };

  config = lib.mkIf config.modules.networking.enable {
    networking = {
      hostName = currentSystemName;
      networkmanager.enable = true;
    };
  };
}
