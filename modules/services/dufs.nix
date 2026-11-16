topLevel: {
  flake.modules.nixos.dufs =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {

      services.caddy.virtualHosts."files.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.dufs.port}
        forward_auth localhost:${toString config.services.tinyauth.settings.SERVER_PORT} {
          uri /api/auth/caddy
        }
      '';

      services.dufs = {
        enable = true;
        settings = {
          allow-all = true;
        };
      };
    };
}
