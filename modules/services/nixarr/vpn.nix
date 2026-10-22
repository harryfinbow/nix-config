topLevel: {
  flake.modules.nixos.nixarr =
    {
      config,
      pkgs,
      self,
      ...
    }:
    {
      age.secrets.vpn.file = (topLevel.self + "/secrets/vpn.age");

      nixarr.vpn = {
        enable = true;
        wgConf = config.age.secrets.vpn.path;
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
              http get https://ipv4.am.i.mullvad.net/json | print $"($in | get ip) [($in | get organization)]"

              # Retrieve IPv6 address
              print "Retrieving IPv6 address..."
              http get https://ipv6.am.i.mullvad.net/json | print $"($in | get ip) [($in | get organization)]"
            '';
          in
          "${vpn-test}/bin/vpn-test";
      };
    };
}
