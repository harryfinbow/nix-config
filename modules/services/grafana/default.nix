topLevel: {
  flake.modules.nixos.grafana =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      services.grafana = {
        enable = true;
        settings = {
          server.http_port = 3100;
          panels.disable_sanitize_html = true; # Required for Blocky dashboard
          security.secret_key = "SW2YcwTIb9zpOOhoPsMm"; # TODO: Change this to point at something secure
        };

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
        etc."grafana/dashboards/blocky.json".source = ./dashboards/blocky.json;
        etc."grafana/dashboards/node-exporter.json".source = ./dashboards/node-exporter.json;
      }
      // lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ config.services.grafana.dataDir ];
      };
    };
}
