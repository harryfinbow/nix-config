# This isn't in use but keeping as an example for future
{
  microvm.vms = {
    minecraft-server = {
      config = {
        microvm = {
          vcpu = 2;
          mem = 8192;

          volumes = [{
            mountPoint = "/";
            image = "/var/lib/microvms/minecraft-server/rootfs.img";
            size = 16384;
          }];

          shares = [{
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
            tag = "ro-store";
            proto = "virtiofs";
          }];

          interfaces = [{
            id = "vm-mc-server";
            type = "tap";
            mac = "02:00:00:00:00:01";
          }];
        };

        systemd.network = {
          enable = true;

          networks = {
            "19-docker" = {
              matchConfig.Name = "veth*";
              linkConfig = {
                Unmanaged = true;
              };
            };
            "20-lan" = {
              matchConfig.Type = "ether";
              networkConfig = {
                Address = "10.0.0.3/24";
                Gateway = "10.0.0.1";
              };
            };
          };  
        };

        services.openssh.enable = true;
        users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta"];

        systemd.tmpfiles.rules = [ "d /var/lib/minecraft-server/cisco 0770 root root -" ];

        virtualisation = {
          containers.enable = true;
          podman = {
            enable = true;
            defaultNetwork.settings.dns_enabled = true;
          };

          oci-containers = {
            backend = "podman";
            containers = {
              cisco = {
                image = "itzg/minecraft-server";
                environment = {
                  EULA = "true";
                  TYPE = "CURSEFORGE";
                  CF_SERVER_MOD = "https://mediafilez.forgecdn.net/files/6371/971/CARPG%20Ultimate%20V7b%20Serv.zip";
                  VERSION = "1.19.2";
                  MEMORY = "6G";
                };
                volumes = [ "/var/lib/minecraft-server/cisco:/data" ];
                ports = [ "25565:25565" ];
              };
            };
          };
        };
      };
    };
  };
}
