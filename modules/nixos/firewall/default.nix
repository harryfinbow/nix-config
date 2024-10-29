{ lib, config, ... }:

{
  options.firewall = {
    enable = lib.mkEnableOption "enables firewall";
  };

  config = lib.mkIf config.firewall.enable {
    networking.firewall = {
      enable = true;

      # https://wiki.bambulab.com/en/general/printer-network-ports
      allowedUDPPorts = [ 1990 2021 ];
    };
  };
}
