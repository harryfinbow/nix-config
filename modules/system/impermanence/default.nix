{ inputs, ... }:

{
  flake.modules.nixos.impermanence = {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persist/system" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /persist/home 0777 root root -"
      "d /persist/home/harry 0700 harry users -"
    ];

    programs.fuse.userAllowOther = true;
  };

  flake.modules.homeManager.impermanence =
    { config, ... }:
    {
      home.persistence."/persist" = {
        directories = [
          ".ssh"
          "Games"
          "git"
          "notes"

          # TODO: Where should these live?
          ".local/share/vulkan"
        ];
      };
    };

}
