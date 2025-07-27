{
  inputs,
  lib,
  config,
  ...
}:

{
  options.modules.impermanence = {
    enable = lib.mkEnableOption "enables impermanence";
  };

  config = lib.mkIf config.modules.impermanence.enable {
    # https://github.com/nix-community/impermanence/issues/121
    boot.initrd.systemd.services.impermanence = {
      description = "Rollback root subvolume to a clean state (requires btrfs)";
      wantedBy = [ "initrd.target" ];
      before = [ "sysroot.mount" ];
      after = [ "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device" ];
      requires = [ "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        MNTPOINT=$(mktemp -d)
        mount /dev/disk/by-partlabel/disk-main-root $MNTPOINT -o subvol=/

        trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT

        # Recursively delete child subvolumes (as `btrfs subvolume delete` doesn't)
        btrfs subvolume list -o $MNTPOINT/rootfs |
        cut -f9 -d' ' |
        while read SUBVOLUME; do
          echo "deleting $SUBVOLUME..."
          btrfs subvolume delete "$MNTPOINT/$SUBVOLUME"
        done

        echo "deleting $MNTPOINT/rootfs..."
        btrfs subvolume delete $MNTPOINT/rootfs

        echo "creating snapshot..."
        btrfs subvolume snapshot $MNTPOINT/rootfs@blank $MNTPOINT/rootfs
      '';
    };

    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /persist/home 0777 root root -"
      "d /persist/home/harry 0700 harry users -"
    ];

    programs.fuse.userAllowOther = true;

  };

}
