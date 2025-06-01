# Not in use - only kept as example
# Based on https://github.com/NixOS/nixpkgs/blob/62b852f6c6742134ade1abdd2a21685fd617a291/nixos/tests/oci-containers.nix#L66
{ config, lib, ... }:

{
  options.modules.minecraft-server = {
    enable = lib.mkEnableOption "enables minecraft-server";
  };

  config = lib.mkIf config.modules.minecraft-server.enable {
    users = {
      groups.minecraft-server = { };
      users.minecraft-server = {
        # https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md#etcsubuid-and-etcsubgid-configuration
        autoSubUidGidRange = true;
        group = "minecraft-server";
        isSystemUser = true;
        uid = 2342;
        linger = true;

        createHome = true;
        home = "/var/lib/containers/minecraft-server";
      };
    };

    networking.firewall.allowedTCPPorts = [ 25565 ];

    systemd.tmpfiles.rules = [ "d /var/lib/containers/minecraft-server/data 0700 minecraft-server minecraft-server -" ];

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers = {
        containers = {
          minecraft-server = {
            image = "itzg/minecraft-server@sha256:f2c69c870f963faf975e5cc361cdd929f0e9f063c1d2900a9ef5524167a89529";
            volumes = [ "/var/lib/containers/minecraft-server/data:/data" ];
            ports = [ "25565:25565" ];
            podman = {
              user = "minecraft-server";
              # Despite warning, this takes too long on each rebuild
              # sdnotify = "healthy";
            };

            extraOptions = [
              "--memory=10g"
              "--cpus=4"
              "--pids-limit=1000"
              "--security-opt=no-new-privileges"
            ];

            environment = {
              EULA = "true";
              VERSION = "1.19.2";
              INIT_MEMORY = "4G";
              MAX_MEMORY = "8G";

              TYPE = "CURSEFORGE";
              CF_SERVER_MOD = "https://mediafilez.forgecdn.net/files/6371/971/CARPG%20Ultimate%20V7b%20Serv.zip";
            };
          };
        };
      };
    };
  };
}
