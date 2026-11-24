topLevel: {
  flake.modules.nixos.nixarr =
    { config, pkgs, ... }:
    {
      nixarr.seerr = {
        enable = true;
        package = pkgs.seerr;
      };

      services.caddy.virtualHosts."movies.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.seerr.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';
    };
}
