topLevel: {
  flake.modules.nixos.actual =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      services.actual.enable = true;

      services.caddy.virtualHosts."budget.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.actual.settings.port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ "/var/lib/actual" ];
      };
    };
}
