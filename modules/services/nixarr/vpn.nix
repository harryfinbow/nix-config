topLevel: {
  flake.modules.nixos.nixarr =
    {
      config,
      pkgs,
      self,
      ...
    }:
    let
      transmissionRPCAddress = config.services.transmission.settings.rpc-bind-address;
      transmissionRPCPort = config.services.transmission.settings.rpc-port;
    in
    {
      imports = [ topLevel.config.flake.modules.nixos.agenix ];

      age.secrets.vpn.file = (topLevel.self + "/secrets/vpn.age");

      nixarr.vpn = {
        enable = true;
        wgConf = config.age.secrets.vpn.path;
      };

      # VPN Port Forwarding
      # https://protonvpn.com/support/port-forwarding-manual-setup/
      # https://github.com/rasmus-kirk/nixarr/issues/16#issuecomment-2982785699
      # Note: `gateway.ip` should be equal to VPN DNS
      systemd.services.transmission-protonvpn = {
        enable = true;
        after = [ "network.target" ];
        wantedBy = [ "default.target" ];
        description = "ProtonVPN Transmission Port Forwarding Service";

        vpnConfinement = {
          enable = true;
          vpnNamespace = "wg"; # This must be "wg", that's what nixarr uses
        };

        serviceConfig = {
          Type = "simple";
          ExecStart = ''
            ${topLevel.inputs.transmission-protonvpn.packages.x86_64-linux.default}/bin/transmission-protonvpn-nat-pmp \
            -transmission.url http://${transmissionRPCAddress}:${toString transmissionRPCPort} \
            -gateway.ip 10.2.0.1 \
            -period 60s
          '';
        };
      };

      systemd.services.vpn-test-service = {
        enable = true;

        vpnConfinement = {
          enable = true;
          vpnNamespace = "wg"; # This must be "wg", that's what nixarr uses
        };

        script =
          let
            vpn-test = pkgs.writers.writeNuBin "vpn-test" ''
              # Retrieve IPv4 address
              print "Retrieving IPv4 address..."
              http get ipinfo.io/json | print $"($in | get ip) [($in | get org)]"

              # Retrieve IPv6 address
              print "Retrieving IPv6 address..."
              http get v6.ipinfo.io/json | print $"($in | get ip) [($in | get org)]"
            '';
          in
          "${vpn-test}/bin/vpn-test";
      };
    };
}
