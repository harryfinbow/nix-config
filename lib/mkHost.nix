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

  nixosModules = with inputs; [
    disko.nixosModules.default
    home-manager.nixosModules.home-manager
    impermanence.nixosModules.impermanence
    nixos-generators.nixosModules.all-formats
    stylix.nixosModules.stylix
  ];

  homeManagerModules = with inputs; [
    hyprland.homeManagerModules.default
    agenix.homeManagerModules.default
    impermanence.nixosModules.home-manager.impermanence
    nixvim.homeManagerModules.nixvim
  ];

in
nixosSystem {
  inherit system;
  inherit specialArgs;

  modules = nixosModules ++ [
    # Disable overlays as not being used and takes ages to build
    # ../overlays
    ../modules/nixos
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
