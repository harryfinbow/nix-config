{ lib, config, ... }:

{
  options.modules.firewall = {
    enable = lib.mkEnableOption "enables firewall";
  };

  config = lib.mkIf config.modules.firewall.enable {
    networking.firewall = {
      enable = true;

      # https://wiki.bambulab.com/en/general/printer-network-ports
      allowedUDPPorts = [ 1990 2021 ];
    };
  };
}
