topLevel:
let
  metricsPort = 2019;
in
{
  flake.modules.nixos.caddy =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {
      age.secrets.caddy.file = (topLevel.self + "/secrets/caddy.age");

      systemd.services.caddy.serviceConfig.EnvironmentFile = [ config.age.secrets.caddy.path ];

      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/porkbun@v0.3.1"
            "github.com/mholt/caddy-dynamicdns@v0.0.0-20251231002810-1af4f8876598"
          ];
          hash = "sha256-ocW1XLa5DZcXPB4zbJXo3mj3KvaHw5zgp9CWkZOChUw=";
        };

        globalConfig = ''
          acme_dns porkbun {
            api_key {$API_KEY}
            api_secret_key {$API_SECRET_KEY}
          }
          dynamic_dns {
            provider porkbun {
              api_key {$API_KEY}
              api_secret_key {$API_SECRET_KEY}
            }
            domains {
              {$BASE_DOMAIN} *
            }
            ip_source interface enp1s0
            include fd00::/64
            versions ipv6
          }
          admin localhost:${toString metricsPort}
          metrics {
            per_host
          }
        '';

        virtualHosts."*.{$BASE_DOMAIN}".extraConfig = ''
          respond "Not found" 404
        '';

        virtualHosts."health.{$BASE_DOMAIN}".extraConfig = ''
          respond 200
        '';
      };

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          "/var/lib/caddy"
          "/var/log/caddy"
        ];
      };

      services.prometheus.scrapeConfigs = [
        {
          job_name = "caddy";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString metricsPort}" ];
            }
          ];
        }
      ];
    };
}
