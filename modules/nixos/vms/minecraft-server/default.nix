{
  self,
  config,
  inputs,
  lib,
  modulesPath,
  ...
}:

let
  data-path = "/var/lib/containers/minecraft-server/data";
in
{
  options.modules.vm.minecraft-server = {
    enable = lib.mkEnableOption "enables minecraft-server microvm";
  };

  config = lib.mkIf config.modules.vm.minecraft-server.enable {

    # Ensure persist directory exists ahead of time
    systemd.tmpfiles.rules = [ "d /persist/microvms/minecraft-server 0770 harry users -" ];

    microvm.vms = {
      minecraft-server = {
        config = {
          imports = [
            # (modulesPath + "/profiles/minimal.nix")
            inputs.agenix.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
          ];

          age.secrets.ddclient.file = (self + "/secrets/ddclient.age");

          microvm = {
            hypervisor = "cloud-hypervisor";
            optimize.enable = true;

            vcpu = 2; # Minecraft Servers are mainly single core
            hotplugMem = 10240; # Initial Memory Allocation (10 GiB)
            hotpluggedMem = 4096; # Memory Limit (4 GiB)

            # Share Nix store with host to reduce image size
            shares = [
              {
                source = "/nix/store";
                mountPoint = "/nix/.ro-store";
                tag = "ro-store";
                proto = "virtiofs";
              }
              {
                source = "/persist/microvms/minecraft-server";
                mountPoint = "/persist";
                tag = "persist";
                proto = "virtiofs";
              }
            ];

            # Attach directly to physical interface
            interfaces = [
              {
                id = "vm-mc-server";
                mac = "02:01:8a:15:cd:28"; # Randomly generated with VM prefix (02)
                type = "macvtap";
                macvtap = {
                  mode = "private";
                  link = "enp1s0";
                };
              }
            ];
          };

          fileSystems."/persist".neededForBoot = lib.mkForce true;
          environment.persistence."/persist" = {
            hideMounts = true;
            directories = [
              "/var/lib/nixos" # GID/UID Mappings
              "/var/lib/systemd/coredump"
              # Persist container images due to refetching image causing systemd unit to timeout
              # https://github.com/astro/microvm.nix/issues/317
              "/var/lib/containers/storage"

              "${data-path}"
            ];
          };

          # Fails intermittently with `invalid user 'ddclient'`
          # https://github.com/NixOS/nixpkgs/issues/350408
          services.ddclient = {
            enable = true;
            configFile = "/run/agenix/ddclient";
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
                  # Static IPv4 address
                  Address = "10.0.0.3/24";
                  Gateway = "10.0.0.1";
                };
              };
            };
          };

          networking.firewall = {
            enable = true;
            allowedTCPPorts = [ 25565 ];
          };

          services.openssh = {
            enable = true;
            # Instead of `persisting` the entirety of `/etc/ssh` as fails to boot
            # probably due to other stuff not being able to be created there
            hostKeys = [
              {
                path = "/persist/etc/ssh/ssh_host_ed25519_key";
                type = "ed25519";
              }
              {
                path = "/persist/etc/ssh/ssh_host_rsa_key";
                type = "rsa";
                bits = 4096;
              }
            ];
          };

          # TODO: Rework SSH access
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta"
          ];

          # Ensure server data directory exists ahead of time
          systemd.tmpfiles.rules = [ "d ${data-path} 0770 root root -" ];

          virtualisation = {
            containers.enable = true;
            podman = {
              enable = true;
              defaultNetwork.settings = {
                # Enable IPv6 networking
                # TODO: Should I just use --host instead?
                ipv6_enabled = true;
                subnets = [
                  {
                    subnet = "10.88.0.0/16";
                    gateway = "10.88.0.1";
                  }
                  {
                    subnet = "fd00::/80";
                    gateway = "fd00::1";
                  }
                ];
              };
            };

            # Minecraft Server service running on Podman container
            oci-containers = {
              backend = "podman";
              containers = {
                minecraft-server = {
                  image = "itzg/minecraft-server@sha256:f2c69c870f963faf975e5cc361cdd929f0e9f063c1d2900a9ef5524167a89529";
                  volumes = [ "${data-path}:/data" ];
                  ports = [ "[::]:25565:25565" ];

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
