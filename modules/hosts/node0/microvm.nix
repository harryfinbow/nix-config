topLevel:
let
  pkgs = null; # https://github.com/microvm-nix/microvm.nix/pull/218
  extraModules = [ topLevel.config.flake.modules.nixos.microvm ];
in
{
  flake.modules.nixos.node0 = {
    microvm.vms = {
      vm0 = {
        inherit pkgs;
        config = topLevel.config.flake.modules.nixos.vm0;
        extraModules = extraModules ++ [
          {
            microvm = {
              vcpu = 4;
              hotplugMem = 8192; # Maximum Memory (8 GiB)
              hotpluggedMem = 4096; # Initial Memory (4 GiB)

              shares = [
                {
                  source = "/persist/microvms/vintagestory";
                  mountPoint = "/var/lib/vintagestory"; # TODO: Is there a way to access this from the service option?
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
          }
        ];
      };
    };
  };
}
