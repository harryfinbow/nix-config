topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.sonarr.enable = true;

      # https://wiki.servarr.com/sonarr/faq-v4#forced-authentication
      services.caddy.virtualHosts."sonarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.sonarr.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';
    };
}
