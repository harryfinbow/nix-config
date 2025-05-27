{ config, lib, ... }:

let
  data-path = "/var/lib/containers/minecraft-server/data";
in
{
  options.modules.vm.minecraft-server = {
    enable = lib.mkEnableOption "enables minecraft-server microvm";
  };

  config = lib.mkIf config.modules.vm.minecraft-server.enable {
    microvm.vms = {
      minecraft-server = {
        config = {
          microvm = {
            hypervisor = "cloud-hypervisor";
            optimize.enable = true;

            vcpu = 2; # Minecraft Servers are mainly single core
            hotplugMem = 10240; # Initial Memory Allocation (10 GiB)
            hotpluggedMem = 4096; # Memory Limit (4 GiB)

            # Server Data Volume
            volumes = [{
              mountPoint = "${data-path}";
              image = "/var/lib/microvms/minecraft-server/minecraft-server.img";
              size = 4096;
            }];

            # Share Nix store with host to reduce image size
            shares = [{
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }];

            # Attach directly to physical interface
            interfaces = [{
              id = "vm-mc-server";
              mac = "02:01:8a:15:cd:28"; # Randomly generated with VM prefix (02)
              type = "macvtap";
              macvtap = {
                mode = "private";
                link = "enp1s0";
              };
            }];
          };

          systemd.network = {
            enable = true;

            networks = {
              # Networkd should not try to manage Podman networks
              "19-docker" = {
                matchConfig.Name = "veth*";
                linkConfig = {
                  Unmanaged = true;
                };
              };

              # VM network attached to `tap` interface
              "20-lan" = {
                matchConfig.Type = "ether";
                networkConfig = {
                  Address = "10.0.0.3/24";
                  Gateway = "10.0.0.1";
                };
              };
            };
          };

          # TODO: Rework SSH access
          services.openssh.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta"
          ];

          # Create data directory to mount into container
          systemd.tmpfiles.rules = [ "d ${data-path} 0770 root root -" ];

          virtualisation = {
            containers.enable = true;
            podman = {
              enable = true;
              defaultNetwork.settings.dns_enabled = true;
            };

            # Minecraft Server service running on Podman container
            oci-containers = {
              backend = "podman";
              containers = {
                minecraft-server = {
                  image = "itzg/minecraft-server@sha256:f2c69c870f963faf975e5cc361cdd929f0e9f063c1d2900a9ef5524167a89529";
                  volumes = [ "${data-path}:/data" ];
                  ports = [ "25565:25565" ];

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
      };
    };
  };
}
