topLevel: {
  flake.modules.nixos.mealie =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      services.mealie.enable = true;

      services.caddy.virtualHosts."meals.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.mealie.port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ "/var/lib/mealie" ];
      };
    };
}
