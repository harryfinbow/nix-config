# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, inputs, self }:

name:
{ system
, user
}:

let
  specialArgs = {
    inherit inputs self;
    currentSystem = system;
    currentSystemName = name;
    currentSystemUser = user;
  };

  extraSpecialArgs = {
    inherit inputs self;
    currentSystem = system;
    currentSystemName = name;
    currentSystemUser = user;
  };

  nixosSystem = inputs.nix-darwin.lib.darwinSystem;
  stylixModules = inputs.home-manager.darwinModules;
  homeManagerModules = inputs.home-manager.darwinModules;

in
nixosSystem {
  inherit system;
  inherit specialArgs;

  modules = [
    ../modules/darwin
    ../hosts/${name}

    stylixModules
    homeManagerModules

    {
      home-manager = {
        inherit extraSpecialArgs;

        useGlobalPkgs = true;
        useUserPackages = true;

        users.${user}.imports = [
          # ../modules/home
          ../home/${name}
        ];
      };
    }
  ];
}
