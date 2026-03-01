topLevel: {
  flake.modules.nixos.home-assistant =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      services.caddy.virtualHosts."home.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.home-assistant.config.http.server_port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ config.services.home-assistant.configDir ];
      };

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
            trusted_proxies = [ "::1" ];
            use_x_forwarded_for = true;
          };
        };
      };
    };
}
