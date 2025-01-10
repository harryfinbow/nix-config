{ nixpkgs, inputs, self }:

name:
{ system
, user
}:

let
  extraSpecialArgs = {
    inherit inputs self;
    currentSystem = system;
    currentSystemName = name;
    currentSystemUser = user;
  };

  homeManagerConfiguration = inputs.home-manager.lib.homeManagerConfiguration;
  pkgs = import nixpkgs { inherit system; };

in
homeManagerConfiguration rec {
  inherit pkgs;
  inherit extraSpecialArgs;

  modules = [
    ../modules/home
    ../home/${name}
  ];
}
