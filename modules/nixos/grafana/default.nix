{
  lib,
  config,
  ...
}:

{
  options.modules.grafana = {
    enable = lib.mkEnableOption "enables grafana";
    port = lib.mkOption {
      type = lib.types.port;
      default = 3100;
    };
  };

  config = lib.mkIf config.modules.grafana.enable {
    services.grafana = {
      enable = true;
      settings.server.http_port = config.modules.grafana.port;
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

        datasources.settings.datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
            isDefault = true;
            editable = false;
          }
        ];
      };
    };

    environment.etc."grafana/dashboards/node-exporter.json".source = ./dashboards/node-exporter.json;

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."grafana.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.grafana.settings.server.http_port}
      '';
    };
  };
}
