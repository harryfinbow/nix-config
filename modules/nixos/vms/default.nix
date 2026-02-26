{ inputs, ... }:

{
  # Ensure persist directory exists ahead of time
  systemd.tmpfiles.rules = [ "d /persist/microvms/vintagestory 0770 harry users -" ];

  microvm.vms = {
    vintagestory = {
      autostart = false;
      config = {
        imports = [
          inputs.microvm.nixosModules.microvm
          inputs.vs2nix.nixosModules.default

          {
            microvm = {
              hypervisor = "cloud-hypervisor";
              optimize.enable = true;

              vcpu = 4; # Minecraft Servers are mainly single core
              hotplugMem = 8192; # 8 GiB
              hotpluggedMem = 4096; # 4 GiB
              shares = [
                {
                  source = "/nix/store";
                  mountPoint = "/nix/.ro-store";
                  tag = "ro-store";
                  proto = "virtiofs";
                }
                {
                  source = "/persist/microvms/vintagestory";
                  mountPoint = "/var/lib/vintagestory";
                  tag = "persist";
                  proto = "virtiofs";
                }
              ];

              interfaces = [
                {
                  id = "vm-vintagestory";
                  mac = "02:00:00:00:00:01";
                  type = "macvtap";
                  macvtap = {
                    mode = "private";
                    link = "enp1s0";
                  };
                }
              ];
            };

            # TODO: Rework SSH access
            users.users.root.openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta"
            ];

            services.openssh = {
              enable = true;
              settings = {
                PasswordAuthentication = false;
              };
            };

            services.vintagestory = {
              enable = true;
              openFirewall = true;
            };
          }
        ];
      };
    };
  };
}
