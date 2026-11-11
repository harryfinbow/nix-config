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
        "restic/memos/repository".file = (topLevel.self + "/secrets/restic/memos/repository.age");
        "restic/memos/password".file = (topLevel.self + "/secrets/restic/memos/password.age");
        "restic/memos/credentials".file = (topLevel.self + "/secrets/restic/memos/credentials.age");
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

      services.restic.backups."memos" =
        let
          databasePath = "${config.services.memos.dataDir}/memos_prod.db";
          backupPath = "${databasePath}.bak";
        in
        {
          initialize = true;

          repositoryFile = config.age.secrets."restic/memos/repository".path;
          passwordFile = config.age.secrets."restic/memos/password".path;
          environmentFile = config.age.secrets."restic/memos/credentials".path;

          paths = [ backupPath ];

          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 5"
            "--keep-monthly 12"
            "--keep-yearly 75"
          ];

          timerConfig = {
            OnCalendar = "04:00"; # 4am everyday
            Persistent = true;
            RandomizedDelaySec = 600;
          };

          backupPrepareCommand = "${lib.getExe pkgs.sqlite} -- ${databasePath} '.backup ${backupPath}'";
        };
    };
}
