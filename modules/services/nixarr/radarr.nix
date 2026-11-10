topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.radarr.enable = true;

      # https://wiki.servarr.com/radarr/faq#forced-authentication
      services.caddy.virtualHosts."radarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.radarr.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';
    };
}
