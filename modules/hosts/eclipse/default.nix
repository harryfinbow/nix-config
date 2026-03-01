{ config, ... }:
let
  darwinModules = config.flake.modules.darwin;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "desktop/darwin"
    "terminal"
    "work"

    # Users
    "harryf"
  ];
in
{
  flake.modules.darwin.eclipse =
    { lib, ... }:
    {
      imports = map (name: darwinModules.${name}) (
        lib.filter (name: lib.hasAttr name darwinModules) modules
      );

      home-manager.users.harryf.imports = [ config.flake.modules.homeManager.eclipse ];

      system.stateVersion = 4;
    };

  flake.modules.homeManager.eclipse =
    { lib, ... }:
    {
      imports = map (name: homeManagerModules.${name}) (
        lib.filter (name: lib.hasAttr name homeManagerModules) modules
      );

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
