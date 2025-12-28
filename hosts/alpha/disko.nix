{
  device ? "dev/nvme0n1",
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              end = "-64G";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  "/nix" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                  "/persist" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/persist";
                  };
                };
                postCreateHook = ''
                  MNTPOINT=$(mktemp -d)
                  mount /dev/disk/by-partlabel/disk-main-root $MNTPOINT -o subvol=/
                  trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                  btrfs subvolume snapshot $MNTPOINT/rootfs $MNTPOINT/rootfs@blank
                '';
              };
            };
            swap = {
              size = "100%"; # use remaining space (64GB)
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
