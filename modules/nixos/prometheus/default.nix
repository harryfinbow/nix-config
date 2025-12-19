{
  lib,
  config,
  ...
}:

{
  options.modules.prometheus = {
    enable = lib.mkEnableOption "enables prometheus";
    port = lib.mkOption {
      type = lib.types.port;
      default = 9001;
    };
  };

  config = lib.mkIf config.modules.prometheus.enable {
    services.prometheus = {
      enable = true;
      port = config.modules.prometheus.port;
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
        {
          job_name = "caddy";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.modules.caddy.metrics_port}" ];
            }
          ];
        }
      ];
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."prometheus.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.prometheus.port}
      '';
    };
  };
}
