{
  flake.modules.nixos.blocky =
    { config, ... }:
    {
      services.blocky = {
        enable = true;
        settings = {
          ports = {
            dns = 53;
            http = 4000;
          };

          upstreams.groups.default = [
            "https://one.one.one.one/dns-query"
            "https://dns.mullvad.net/dns-query"
          ];

          bootstrapDns = {
            upstream = "https://one.one.one.one/dns-query";
            ips = [
              "1.1.1.1"
              "1.0.0.1"
            ];
          };

          blocking = {
            denylists = {
              ads = [ "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/multi.txt" ];
            };
            clientGroupsBlock = {
              default = [ "ads" ];
            };
          };

          prometheus.enable = true;
        };
      };

      networking.firewall = {
        allowedTCPPorts = [ config.services.blocky.settings.ports.dns ];
        allowedUDPPorts = [ config.services.blocky.settings.ports.dns ];
      };

      # Do not bind to port 53 (which clashes with Blocky)
      services.resolved.settings.Resolve.DNSStubListener = "no";

      services.prometheus.scrapeConfigs = [
        {
          job_name = "blocky";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.blocky.settings.ports.http}" ];
            }
          ];
        }
      ];
    };
}
