topLevel: {
  flake.modules.nixos."beszel/hub" =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {
      age.secrets."tinyauth/beszel".file = (topLevel.self + "/secrets/tinyauth/beszel.age");

      systemd.services.tinyauth.serviceConfig.EnvironmentFile = [
        config.age.secrets."tinyauth/beszel".path
      ];

      services.caddy.virtualHosts."beszel.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.beszel.hub.port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          config.services.beszel.hub.dataDir
        ];
      };

      services.beszel.hub.enable = true;
    };
}
