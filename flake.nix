{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

    hyprland.url = "github:hyprwm/Hyprland/v0.38.1";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    stylix.url = "github:danth/stylix";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { self, nixpkgs, stylix, ... }@inputs:
    let
      specialArgs = { inherit inputs self; };
      extraSpecialArgs = { inherit inputs self; };

      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.home-manager.nixosModules) home-manager;

      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      nixosConfigurations = {
        hefty = nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/hefty
            stylix.nixosModules.stylix

            home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;

                useGlobalPkgs = true;
                useUserPackages = true;

                users.harry = import ./home/harry;
              };
            }
          ];
        };
      };

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            end-of-file-fixer.enable = true;
            trim-trailing-whitespace.enable = true;

            nixpkgs-fmt.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });
    };
}
