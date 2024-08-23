{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Replaces $XDG_RUNTIME_DIR with ${XDG_RUNTIME_DIR} which Hyprpaper doesn't evaluate
    agenix.url = "github:ryantm/agenix?ref=c2fc0762bbe8feb06a2e59a364fa81b3a57671c9";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    hyprland.url = "github:hyprwm/Hyprland/v0.38.1";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # Theme just isn't applying
    stylix.url = "github:danth/stylix?ref=1d3826ceed91ae67562f28ee2e135813a11e47a6";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      specialArgs = { inherit inputs self; };
      extraSpecialArgs = { inherit inputs self; };

      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.nix-darwin.lib) darwinSystem;
      inherit (inputs.home-manager) nixosModules;
      inherit (inputs.home-manager) darwinModules;

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
            inputs.disko.nixosModules.default
            inputs.stylix.nixosModules.stylix

            nixosModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;

                useGlobalPkgs = true;
                useUserPackages = true;

                users.harry.imports = [
                  ./home/harry
                ];
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        dense = darwinSystem {
          inherit specialArgs;
          system = "aarch64-darwin";
          modules = [
            ./hosts/dense
            inputs.stylix.darwinModules.stylix

            darwinModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;

                useGlobalPkgs = true;
                useUserPackages = true;

                users.harryf.imports = [
                  ./home/harryf
                ];
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
