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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.46.2&submodules=1";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    stylix.url = "github:danth/stylix";

    # https://github.com/NixOS/nixpkgs/issues/327982
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mkHost = import ./lib/mkHost.nix { inherit nixpkgs inputs self; };
      mkHome = import ./lib/mkHome.nix { inherit nixpkgs inputs self; };
      mkDarwin = import ./lib/mkDarwin.nix { inherit nixpkgs inputs self; };

      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      nixosConfigurations.alpha = mkHost "alpha" rec {
        system = "x86_64-linux";
        user = "harry";
      };

      darwinConfigurations.bravo = mkDarwin "bravo" rec {
        system = "aarch64-darwin";
        user = "harryf";
      };

      nixosConfigurations.charlie = mkHost "charlie" rec {
        system = "aarch64-linux";
        user = "harry";
      };

      nixosConfigurations.delta = mkHost "delta" rec {
        system = "x86_64-linux";
        user = "harry";
      };

      nixosConfigurations.echo = mkHost "echo" rec {
        system = "x86_64-linux";
        user = "harry";
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
