{
  config,
  lib,
  ...
}:
let
  mkModules = req: all: map (name: all.${name}) (lib.filter (name: lib.hasAttr name all) req);

  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "ssh"
    "terminal"

    # Users
    "harry"
  ];
in
{
  flake.modules.nixos.node1 = { modulesPath, ... }: {
    imports = (mkModules modules nixosModules) ++ [
      (modulesPath + "/profiles/minimal.nix")
    ];

    home-manager.users.harry.imports = [ config.flake.modules.homeManager.node1 ];

    # TODO: Enable this globally?
    users.mutableUsers = false;

    networking = {
      hostName = "node1";
      useDHCP = false; # Not compatible with `systemd.network.enable`
    };

    zramSwap.enable = true;
    swapDevices = [
      {
        device = "/swap";
        size = 1024;
      }
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "26.05";

    # Wireguard
    networking.firewall.allowedUDPPorts = [ 51820 ];
    systemd.network = {
      enable = true;

      netdevs = {
        "50-wg0" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg0";
            MTUBytes = "1300";
          };
          wireguardConfig = {
            PrivateKeyFile = "/etc/nixos/wgPrivateKey";
            ListenPort = 51820;
          };
          wireguardPeers = [
            {
              PublicKey = "Xsk7rOj8eC/kANXHf6xmbvKYlLQNwbhMss8K6+GCx1c=";
              AllowedIPs = [ "10.99.0.3/32" ];
            }
            {
              PublicKey = "Zk7R+NizIUpqhyqX9VF7POQS54UU4uMmFkWFep4FaA8=";
              AllowedIPs = [ "10.99.0.1/32" ];
            }
            {
              PublicKey = "b6Hoq9aeA7CVioh8o+m30LF1h/W6DoYLmx12eGv7hig=";
              AllowedIPs = [ "10.99.0.4/32" ];
            }
          ];
        };
      };

      networks = {
        "40-wan" = {
          matchConfig.MACAddress = "de:00:00:6e:0e:3f";
          networkConfig = {
            DHCP = "yes";
            IPv6AcceptRA = true;
          };
        };

        "50-wg0" = {
          matchConfig.Name = "wg0";
          address = [ "10.99.0.2/24" ];
          networkConfig = {
            IPMasquerade = "both";
            IPv4Forwarding = true;
            IPv6Forwarding = true;
          };
        };
      };
    };
  };

  flake.modules.homeManager.node1 = {
    imports = mkModules modules homeManagerModules;

    # The `extraPackages` make the closure too large for the 10GB disk
    programs.helix.extraPackages = lib.mkForce [ ];

    # Even having this target enabled pulls in a QT dependency which is ~1GB
    stylix.targets.qt.enable = false;

    programs.zellij = {
      enableFishIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = true;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "26.05";
  };
}
