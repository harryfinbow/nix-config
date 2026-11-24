topLevel: {
  flake.modules.nixos.actual =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      services.actual.enable = true;

      services.caddy.virtualHosts."budget.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.actual.settings.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ "/var/lib/actual" ];
      };
    };
}
