topLevel: {
  flake.modules.nixos.prometheus =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      services.prometheus = {
        enable = true;
        globalConfig.scrape_interval = "15s"; # To match Grafana datasource scrape interval (else `$__rate_interval` breaks)

        exporters = {
          node = {
            enable = true;
            enabledCollectors = [
              "systemd"
              "processes"
            ];
            port = config.services.prometheus.port + 1;
          };
        };

        scrapeConfigs = [
          {
            job_name = "node";
            static_configs = [
              {
                targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
              }
            ];
          }
        ];
      };

      services.grafana.provision.datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
          isDefault = true;
          editable = false;
        }
      ];

      services.caddy.virtualHosts."prometheus.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.prometheus.port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          "/var/lib/${toString config.services.prometheus.stateDir}"
        ];
      };
    };
}
