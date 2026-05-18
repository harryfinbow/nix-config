topLevel: {
  flake.modules.nixos.nixarr =
    { config, pkgs, ... }:
    {
      nixarr.jellyseerr = {
        enable = true;
        package = pkgs.seerr;
      };

      services.caddy.virtualHosts."movies.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.jellyseerr.port}
      '';
    };
}
