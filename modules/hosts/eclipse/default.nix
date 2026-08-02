{ config, lib, ... }:
let
  mkModules = req: all: map (name: all.${name}) (lib.filter (name: lib.hasAttr name all) req);

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
  flake.modules.darwin.eclipse = {
    imports = mkModules modules darwinModules;

    home-manager.users.harryf.imports = [ config.flake.modules.homeManager.eclipse ];

    nixpkgs.hostPlatform = "aarch64-darwin";

    system.stateVersion = 4;
  };

  flake.modules.homeManager.eclipse = {
    imports = mkModules modules homeManagerModules;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
