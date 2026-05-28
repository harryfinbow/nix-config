{ config, lib, ... }:
let
  mkModules = req: all: map (name: all.${name}) (lib.filter (name: lib.hasAttr name all) req);

  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "audio"
    "bluetooth"
    "desktop/nixos"
    "games"
    "persistence"
    "terminal"

    # Hardware
    "nvidia"

    # Users
    "harry"

    # Applications
    "bitwarden"
    "discord"
    "orcaslicer"
  ];
in
{
  flake.modules.nixos.polaris = {
    imports = mkModules modules nixosModules;

    home-manager.users.harry.imports = [ config.flake.modules.homeManager.polaris ];

    networking = {
      hostName = "polaris";
      networkmanager.enable = true;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
  };

  flake.modules.homeManager.polaris = {
    imports = mkModules modules homeManagerModules;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
