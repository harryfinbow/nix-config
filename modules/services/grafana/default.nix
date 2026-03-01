topLevel: {
  flake.modules.nixos.grafana =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      services.grafana = {
        enable = true;

        # TODO: Change this to point at something secure
        settings.security.secret_key = "SW2YcwTIb9zpOOhoPsMm";

        provision = {
          enable = true;

          dashboards.settings.providers = [
            {
              name = "default";
              disableDeletion = true;
              options = {
                path = "/etc/grafana/dashboards";
                foldersFromFilesStructure = true;
              };
            }
          ];
        };
      };

      services.caddy.virtualHosts."grafana.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.grafana.settings.server.http_port}
      '';

      environment = {
        etc."grafana/dashboards/node-exporter.json".source = ./dashboards/node-exporter.json;
      }
      // lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ config.services.grafana.dataDir ];
      };
    };
}
