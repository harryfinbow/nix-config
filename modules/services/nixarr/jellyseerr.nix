topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      nixarr.jellyseerr.enable = true;

      services.caddy.virtualHosts."movies.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.jellyseerr.port}
      '';
    };
}
