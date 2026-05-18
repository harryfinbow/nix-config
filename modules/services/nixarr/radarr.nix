topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.radarr.enable = true;

      services.caddy.virtualHosts."radarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.radarr.port}
      '';
    };
}
