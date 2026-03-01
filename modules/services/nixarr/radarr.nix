topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      nixarr.radarr.enable = true;

      services.caddy.virtualHosts."radarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.radarr.port}
      '';
    };
}
