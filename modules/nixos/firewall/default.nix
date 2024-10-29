{
  networking.firewall = {
    enable = true;

    # https://wiki.bambulab.com/en/general/printer-network-ports
    allowedUDPPorts = [ 1990 2021 ];
  };
}
