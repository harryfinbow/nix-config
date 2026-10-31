topLevel:
let
  pkgs = null; # https://github.com/microvm-nix/microvm.nix/pull/218
  extraModules = [ topLevel.config.flake.modules.nixos.microvm ];
in
{
  flake.modules.nixos.minecraft =
    { config, lib, ... }:
    let
      vmConfig = config.microvm.vms.minecraft.config.config;
    in
    {
      # Backups
      age.secrets = {
        "restic/credentials".file = (topLevel.self + "/secrets/restic/credentials.age");
        "restic/password".file = (topLevel.self + "/secrets/restic/password.age");
        "restic/minecraft".file = (topLevel.self + "/secrets/restic/minecraft.age");
      };
      services.restic.backups =
        let
          minecraftDir = "/persist/microvms/minecraft/${vmConfig.services.minecraft-server.dataDir}";
        in
        {
          "minecraft" = {
            initialize = true;

            repositoryFile = config.age.secrets."restic/minecraft".path;
            passwordFile = config.age.secrets."restic/password".path;
            environmentFile = config.age.secrets."restic/credentials".path;

            paths = [ minecraftDir ];

            exclude = [
              "${minecraftDir}/.cache"
              "${minecraftDir}/libraries"
              "${minecraftDir}/logs"
              "${minecraftDir}/versions"
              "${minecraftDir}/eula.txt"
              "${minecraftDir}/usercache.json"
            ];

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

            # TODO: save-off → save-all flush / save-on
            backupPrepareCommand = null;
            backupCleanupCommand = null;
          };
        };

      microvm.vms.minecraft = {
        inherit extraModules pkgs;

        config = {
          imports = with topLevel.config.flake.modules.nixos; [
            default
            ssh
            harry
          ];

          # TODO: This is due to `macvtap` not allowing connections on the same interface
          services.resolved.settings.Resolve.Domains = [ "~." ];
          services.resolved.settings.Resolve.DNS = [
            "1.1.1.1"
            "1.0.0.1"
          ];

          microvm = {
            vcpu = 4;
            hotplugMem = 8192; # Maximum Memory (8 GiB)
            hotpluggedMem = 4096; # Initial Memory (4 GiB)

            interfaces = [
              {
                id = "vm0";
                mac = "02:00:00:00:00:01";
                type = "macvtap";
                macvtap = {
                  mode = "private";
                  link = "enp1s0";
                };
              }
            ];
          };

          services.minecraft-server = {
            enable = true;
            openFirewall = true;

            eula = true;
            jvmOpts = "-Xmx8192M -Xms4096M";
          };

          environment.persistence."/persist".directories = [
            {
              directory = vmConfig.services.minecraft-server.dataDir;
              user = vmConfig.users.users.minecraft.name;
              group = vmConfig.users.groups.minecraft.name;
              mode = "0755";
            }
          ];

          age.secrets.rathole-client.file = (topLevel.self + "/secrets/rathole-client.age");
          services.rathole = {
            enable = true;
            role = "client";
            credentialsFile = vmConfig.age.secrets.rathole-client.path;
          };

          # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
          system.stateVersion = "26.11";
        };
      };
    };
}
