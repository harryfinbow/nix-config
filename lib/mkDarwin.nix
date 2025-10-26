{
  inputs,
  self,
}:

name:
{
  system,
  user,
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

  darwinSystem = inputs.nix-darwin.lib.darwinSystem;

  darwinModules = with inputs; [
    stylix.darwinModules.stylix
    home-manager.darwinModules.home-manager
  ];

  homeManagerModules = with inputs; [
    agenix.homeManagerModules.default
    impermanence.nixosModules.home-manager.impermanence
    nixvim.homeModules.nixvim
  ];

in
darwinSystem {
  inherit system;
  inherit specialArgs;

  modules = darwinModules ++ [
    ../modules/darwin
    ../hosts/${name}

    {
      home-manager = {
        inherit extraSpecialArgs;

        useGlobalPkgs = true;
        useUserPackages = true;

        users.${user}.imports = homeManagerModules ++ [
          ../modules/home
          ../home/${name}
        ];
      };
    }
  ];
}
