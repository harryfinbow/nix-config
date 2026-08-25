{
  flake.modules.nixos.home-assistant = {
    services.matterjs-server.enable = true;

    # Allow mDNS which is required for Matter
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
