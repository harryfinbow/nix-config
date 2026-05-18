topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.sonarr.enable = true;

      services.caddy.virtualHosts."sonarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.sonarr.port}
      '';
    };
}
