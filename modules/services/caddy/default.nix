topLevel:
let
  metricsPort = 2019;
in
{
  flake.modules.nixos.caddy =
    {
      lib,
      options,
      pkgs,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.agenix ];

      age.secrets.caddy.file = (topLevel.self + "/secrets/caddy.age");

      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/porkbun@v0.3.1"
            "github.com/mholt/caddy-dynamicdns@v0.0.0-20250430031602-b846b9e8fb83"
          ];
          hash = "sha256-y+qE2pzWpIUpxVr9tLT4u+pBmb9dY6hPv+FwG7Hp6UA=";
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
