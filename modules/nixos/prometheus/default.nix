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
          job_name = "delta";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
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
