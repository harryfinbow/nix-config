topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.prowlarr.enable = true;

      # https://wiki.servarr.com/prowlarr/faq#forced-authentication
      services.caddy.virtualHosts."prowlarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.prowlarr.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';
    };
}
