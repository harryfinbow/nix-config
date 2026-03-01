{ config, inputs, ... }:
let
  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "impermanence"
    "ssh"
    "terminal"

    # Users
    "harry"

    # Services
    "actual"
    "glance"
    "grafana"
    "home-assistant"
    "linkding"
    "mealie"
    "nixarr"
    "prometheus"
  ];
in
{
  flake.modules.nixos.node0 =
    { lib, ... }:
    {
      imports =
        map (name: nixosModules.${name}) (lib.filter (name: lib.hasAttr name nixosModules) modules)
        ++ [ inputs.microvm.nixosModules.host ];

      home-manager.users.harry.imports = [ config.flake.modules.homeManager.node0 ];

      networking.hostName = "node0";

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      system.stateVersion = "23.11";
    };

  flake.modules.homeManager.node0 =
    { lib, ... }:
    {
      imports = map (name: homeManagerModules.${name}) (
        lib.filter (name: lib.hasAttr name homeManagerModules) modules
      );

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
