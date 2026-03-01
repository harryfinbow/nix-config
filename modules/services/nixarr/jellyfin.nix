{ config, ... }:
{
  flake.modules.nixos.nixarr =
    let
      jellyfinDefaultPort = 8096;
    in
    {
      imports = [ config.flake.modules.nixos.caddy ];

      nixarr.jellyfin.enable = true;

      services.caddy.virtualHosts."watch.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString jellyfinDefaultPort}
      '';
    };
}
