{
  self,
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.caddy = {
    enable = lib.mkEnableOption "enables caddy";
  };

  config = lib.mkIf config.modules.caddy.enable {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/porkbun@v0.3.1"
          "github.com/mholt/caddy-dynamicdns@v0.0.0-20250430031602-b846b9e8fb83"
        ];
        hash = "sha256-yZIgEy46y/XAar0vXcUmuOxp7qLttls015Fizjw8CAw=";
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
      '';

      virtualHosts."*.{$BASE_DOMAIN}".extraConfig = ''
        respond "Not found" 404
      '';

      virtualHosts."health.{$BASE_DOMAIN}".extraConfig = ''
        respond 200
      '';
    };

    age.secrets.caddy.file = (self + "/secrets/caddy.age");
    systemd.services.caddy.serviceConfig.EnvironmentFile = [ config.age.secrets.caddy.path ];

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    environment = lib.mkIf config.modules.impermanence.enable {
      persistence."/persist/system".directories = [
        "/var/lib/caddy"
        "/var/log/caddy"
      ];
    };
  };
}
