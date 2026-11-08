topLevel: {
  flake.modules.nixos.memos =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    let
      port = 5230;
    in
    {
      age.secrets = {
        "tinyauth/memos".file = (topLevel.self + "/secrets/tinyauth/memos.age");
      };

      services.caddy.virtualHosts."notes.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          config.services.memos.dataDir
        ];
      };

      systemd.services.tinyauth.serviceConfig.EnvironmentFile = [
        config.age.secrets."tinyauth/memos".path
      ];

      # https://github.com/NixOS/nixpkgs/issues/561969
      networking.firewall.allowedTCPPorts = [ port ];
      services.memos = {
        enable = true;
        settings = {
          MEMOS_MODE = "prod";
          MEMOS_ADDR = "127.0.0.1";
          MEMOS_PORT = toString port;
          MEMOS_DATA = config.services.memos.dataDir;
          MEMOS_DRIVER = "sqlite";
          MEMOS_INSTANCE_URL = "http://localhost:${toString port}";
        };
      };
    };
}
