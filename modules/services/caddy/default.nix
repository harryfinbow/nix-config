topLevel:
let
  metricsPort = 2019;
in
{
  flake.modules.nixos.caddy =
    { config, lib, ... }:
    {
      # imports = [ topLevel.config.flake.modules.nixos.caddy-prometheus ];

      services.caddy.enable = true;

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

    };

  # This is a work around to allow for the `caddy` module to imported
  # multiple times without its scrape config being repeatedly appended
  flake.modules.nixos.caddy-prometheus = {
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
