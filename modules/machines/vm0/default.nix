topLevel: {
  flake.modules.nixos.vm0 = {
    imports = with topLevel.config.flake.modules.nixos; [
      default
      microvm

      # Services
      vintagestory
    ];

    networking.hostName = "vm0";

    microvm = {
      vcpu = 4;
      hotplugMem = 8192; # Maximum Memory (8 GiB)
      hotpluggedMem = 4096; # Initial Memory (4 GiB)

      shares = [
        {
          source = "/persist/microvms/vintagestory";
          mountPoint = "/var/lib/vintagestory";
          tag = "persist";
          proto = "virtiofs";
        }
      ];

      interfaces = [
        {
          id = "vm0";
          mac = "02:00:00:00:00:02";
          type = "macvtap";
          macvtap = {
            mode = "private";
            link = "eno1";
          };
        }
      ];
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
  };
}
