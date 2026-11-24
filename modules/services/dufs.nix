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
          assets = builtins.fetchTarball {
            url = "https://github.com/TransparentLC/dufs-material-assets/releases/download/v0.47.0/dufs-material-assets-embed.zip";
            sha256 = "sha256-K2bUnbT1kmffdwcmFtELugorUilPUO6Fk41vOnOQHBI=";
          };
        };
      };
    };
}
