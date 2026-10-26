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
          plugins = [ "github.com/caddy-dns/porkbun@v0.3.1" ];
          hash = "sha256-3XnnBdOW8A+LmmcqR94v1ZkyMoMB3EfBWFv0uBzz4cA=";
        };

        globalConfig = ''
          acme_dns porkbun {
            api_key {$API_KEY}
            api_secret_key {$API_SECRET_KEY}
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
