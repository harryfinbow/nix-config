{
  description = "Nixos config flake";
     
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Star Citizen
    # nix-gaming.url = "github:fufexan/nix-gaming";

    # nix-citizen.url = "github:LovingMelody/nix-citizen";
    # nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = {nixpkgs, ...} @ inputs:
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
	# inputs.nix-citizen.nixosModules.StarCitizen

        (import ./disko.nix { device = "/dev/nvme0n1"; })
        ./configuration.nix
      ];
    };
  };
}
