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
    agenix.nixosModules.default
    disko.nixosModules.default
    home-manager.nixosModules.home-manager
    impermanence.nixosModules.impermanence
    microvm.nixosModules.host
    nixarr.nixosModules.default
    nixos-generators.nixosModules.all-formats
    stylix.nixosModules.stylix
    vs2nix.nixosModules.default
  ];

  homeManagerModules = with inputs; [
    agenix.homeManagerModules.default
    impermanence.nixosModules.home-manager.impermanence
    nixvim.homeModules.nixvim
    textfox.homeManagerModules.default
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
