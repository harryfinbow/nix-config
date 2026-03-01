topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      nixarr.prowlarr.enable = true;

      services.caddy.virtualHosts."prowlarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.prowlarr.port}
      '';
    };
}
