topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      nixarr.prowlarr.enable = true;

      services.caddy.virtualHosts."prowlarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.prowlarr.port}
      '';
    };
}
