{
  nixpkgs,
  inputs,
  self,
}:

name:
{
  system,
  user,
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

  homeManagerModules = with inputs; [
    hyprland.homeManagerModules.default
    agenix.homeManagerModules.default
    impermanence.nixosModules.home-manager.impermanence
    nixvim.homeManagerModules.nixvim
  ];

in
homeManagerConfiguration rec {
  inherit pkgs;
  inherit extraSpecialArgs;

  modules = homeManagerModules ++ [
    ../modules/home
    ../home/${name}
  ];
}
