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

  nixosSystem = nixpkgs.lib.nixosSystem;
  diskoModules = inputs.disko.nixosModules.default;
  stylixModules = inputs.stylix.nixosModules.stylix;
  homeManagerModules = inputs.home-manager.nixosModules.home-manager;

in
nixosSystem {
  inherit system;
  inherit specialArgs;

  modules = [
    ../modules/nixos
    ../hosts/${name}

    diskoModules
    stylixModules
    homeManagerModules

    {
      home-manager = {
        inherit extraSpecialArgs;

        useGlobalPkgs = true;
        useUserPackages = true;

        users.${user}.imports = [
          ../modules/home
          ../home/${name}
        ];
      };
    }
  ];
}
