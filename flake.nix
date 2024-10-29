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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.43.0&submodules=1";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    stylix.url = "github:danth/stylix";

    # https://github.com/NixOS/nixpkgs/issues/327982
    zen-browser.url = "github:ch4og/zen-browser-flake";
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
