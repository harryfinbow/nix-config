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
    "tailscale"
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

      networks = {
        "10-enp1s0" = {
          matchConfig.Name = "enp1s0";
          networkConfig = {
            Address = "192.168.1.100/24";
            Gateway = "192.168.1.1";
          };
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
