{
  flake.modules.nixos.home-assistant = {
    services.matter-server.enable = true;

    # Allow mDNS which is required for Matter
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
