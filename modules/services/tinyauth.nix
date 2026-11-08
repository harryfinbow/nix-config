topLevel: {
  flake.modules.nixos.tinyauth =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      # This is required to allow `APPURL` to be defined in the
      # environment file as currently the default settings overrides it
      # https://github.com/NixOS/nixpkgs/blob/c56a87d8e41ce69bd2af57eb35dcc117a9dfca33/nixos/modules/services/security/tinyauth.nix#L187-L190
      options.services.tinyauth.settings = lib.mkOption {
        apply = s: builtins.removeAttrs s [ "APPURL" ];
      };

      config = {
        age.secrets = {
          "tinyauth/config".file = (topLevel.self + "/secrets/tinyauth/config.age");
        };

        services.caddy.virtualHosts."auth.{$BASE_DOMAIN}".extraConfig = ''
          reverse_proxy localhost:${toString config.services.tinyauth.settings.SERVER_PORT}
        '';

        environment = lib.optionalAttrs (options.environment ? persistence) {
          persistence."/persist/system".directories = [ config.services.tinyauth.dataDir ];
        };

        services.tinyauth = {
          enable = true;
          environmentFile = config.age.secrets."tinyauth/config".path;

          settings = {
            SERVER_PORT = 3001;
            TINYAUTH_AUTH_TRUSTEDPROXIES = "127.0.0.1";
          };
        };
      };
    };
}
