topLevel: {
  flake.modules.nixos.microvm = { config, lib, ... }: {
    imports = [ topLevel.inputs.impermanence.nixosModules.impermanence ];

    microvm = {
      hypervisor = "cloud-hypervisor";
      optimize.enable = true;

      shares = [
        {
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          tag = "ro-store";
          proto = "virtiofs";
        }
        {
          source = "/persist/microvms/${config.networking.hostName}";
          mountPoint = "/persist";
          tag = "persist";
          proto = "virtiofs";
        }
      ];
    };

    # Persistence (for SSH host keys)
    fileSystems."/persist".neededForBoot = lib.mkForce true;

    environment.persistence."/persist" = {
      directories = [
        "/var/lib/systemd/coredump"
        "/var/lib/nixos"
        "/var/log"
      ];

      files = [ "/etc/machine-id" ];
    };

    services.openssh = {
      hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
