topLevel: {
  flake.modules.nixos.linkding =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    let
      dataPath = "/var/lib/containers/linkding/data";
      port = 9090;
    in
    {
      age.secrets = {
        "linkding".file = (topLevel.self + "/secrets/linkding.age");
        "restic/linkding/repository".file = (topLevel.self + "/secrets/restic/linkding/repository.age");
        "restic/linkding/password".file = (topLevel.self + "/secrets/restic/linkding/password.age");
        "restic/linkding/credentials".file = (topLevel.self + "/secrets/restic/linkding/credentials.age");
        "tinyauth/linkding".file = (topLevel.self + "/secrets/tinyauth/linkding.age");
      };

      services.caddy.virtualHosts."bookmarks.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString port}
      '';

      systemd.services.tinyauth.serviceConfig.EnvironmentFile = [
        config.age.secrets."tinyauth/linkding".path
      ];

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ dataPath ];
      };

      systemd.tmpfiles.rules = [
        "d ${dataPath} 0700 root root -"
      ];

      virtualisation.oci-containers.containers.linkding = {
        image = "sissbruecker/linkding@sha256:12ffd6f3b48c5d46543d2f38030de1f476d8dcff5f486eb75c9c7cb5941e7127"; # v1.42.0
        volumes = [ "${dataPath}:/etc/linkding/data" ];
        ports = [ "${toString port}:9090" ];
        environmentFiles = [ config.age.secrets.linkding.path ];
      };

      services.restic.backups."linkding" =
        let
          databasePath = "${dataPath}/db.sqlite3";
          backupPath = "${databasePath}.bak";
        in
        {
          initialize = true;

          repositoryFile = config.age.secrets."restic/linkding/repository".path;
          passwordFile = config.age.secrets."restic/linkding/password".path;
          environmentFile = config.age.secrets."restic/linkding/credentials".path;

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
          };

          backupPrepareCommand = "${lib.getExe pkgs.sqlite} -- ${databasePath} '.backup ${backupPath}'";
        };
    };
}
