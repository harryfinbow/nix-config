topLevel: {
  flake.modules.nixos.nixarr =
    { config, ... }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      nixarr.sonarr.enable = true;

      services.caddy.virtualHosts."sonarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.sonarr.port}
      '';
    };
}
