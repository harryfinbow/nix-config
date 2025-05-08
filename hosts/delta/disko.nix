{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
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
              end = "-16G";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                mountpoint = "/";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
            swap = {
              size = "100%"; # use remaining space (8GB)
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
}
