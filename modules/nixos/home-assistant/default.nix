{
  lib,
  config,
  ...
}:

{
  options.modules.home-assistant = {
    enable = lib.mkEnableOption "enables home-assistant";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8123;
    };
  };

  config = lib.mkIf config.modules.home-assistant.enable {
    services.home-assistant = {
      enable = true;

      extraComponents = [
        "isal" # https://www.home-assistant.io/integrations/isal
        "zha"
      ];

      config = {
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };

        automation = "!include automations.yaml";

        homeassistant = {
          time_zone = lib.mkForce null;
        };

        http = {
          server_port = config.modules.home-assistant.port;
          trusted_proxies = [ "::1" ];
          use_x_forwarded_for = true;
        };
      };
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."home.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.home-assistant.config.http.server_port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/hass" ];
    };
  };
}
