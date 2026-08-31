{
  config,
  inputs,
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

    # Services
    "actual"
    "blocky"
    "caddy"
    "cook"
    "glance"
    "grafana"
    "home-assistant"
    "linkding"
    "nixarr"
    "prometheus"
  ];
in
{
  flake.modules.nixos.node0 = {
    imports = (mkModules modules nixosModules) ++ [ inputs.microvm.nixosModules.host ];

    home-manager.users.harry.imports = [ config.flake.modules.homeManager.node0 ];

    networking = {
      hostName = "node0";
      useDHCP = false; # Not compatible with `systemd.network.enable`
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";

    # Networking
    systemd.network = {
      enable = true;
      wait-online.enable = false;

      netdevs = {
        "10-wg1" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg1";
            MTUBytes = "1300";
          };
          wireguardConfig = {
            PrivateKeyFile = "/persist/secrets/wg-private";
            ListenPort = 51820;
          };
          wireguardPeers = [
            {
              PublicKey = "sogAWq75K7Ava751jua1r6USiuySE3YknctHq2lY828=";
              AllowedIPs = [ "10.99.0.0/24" ];
              Endpoint = "51.15.85.67:51820";
              PersistentKeepalive = 25;
            }
          ];
        };
      };

      networks = {
        "10-enp1s0" = {
          matchConfig.Name = "enp1s0";
          networkConfig = {
            Address = "192.168.1.100/24";
            Gateway = "192.168.1.1";
          };
        };

        "10-wg1" = {
          matchConfig.Name = "wg1";
          address = [ "10.99.0.1/24" ];
        };
      };
    };
  };

  flake.modules.homeManager.node0 = {
    imports = mkModules modules homeManagerModules;

    programs.zellij = {
      enableFishIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = true;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
