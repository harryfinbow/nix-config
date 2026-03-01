{ config, ... }:
let
  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "audio"
    "bluetooth"
    "desktop/nixos"
    "games"
    "impermanence"
    "terminal"

    # Hardware
    "nvidia"

    # Users
    "harry"

    # Applications
    "bitwarden"
    "discord"
  ];
in
{
  flake.modules.nixos.polaris =
    { lib, ... }:
    {
      imports = map (name: nixosModules.${name}) (
        lib.filter (name: lib.hasAttr name nixosModules) modules
      );

      home-manager.users.harry.imports = [ config.flake.modules.homeManager.polaris ];

      networking = {
        hostName = "polaris";
        networkmanager.enable = true;
      };

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      system.stateVersion = "23.11";
    };

  flake.modules.homeManager.polaris =
    { lib, ... }:
    {
      imports = map (name: homeManagerModules.${name}) (
        lib.filter (name: lib.hasAttr name homeManagerModules) modules
      );

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
