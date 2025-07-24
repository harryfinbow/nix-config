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

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    # /nix/store/prgaw5y3kjcf91y1ld5g9diqnambgyib-wine-tkg-full-10.8.drv fails to build
    nix-gaming.url = "github:fufexan/nix-gaming?ref=a094fde06697aba9c514b627850261810e771495";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    stylix.url = "github:danth/stylix";

    # https://github.com/NixOS/nixpkgs/pull/414845
    vs2nix.url = "github:dtomvan/vs2nix";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      mkHost = import ./lib/mkHost.nix { inherit nixpkgs inputs self; };
      mkHome = import ./lib/mkHome.nix { inherit nixpkgs inputs self; };
      mkDarwin = import ./lib/mkDarwin.nix { inherit nixpkgs inputs self; };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
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
        nixpkgsOverride = "vintagestory";
      };

      nixosConfigurations.echo = mkHost "echo" rec {
        system = "x86_64-linux";
        user = "harry";
      };

      nixosConfigurations.foxtrot = mkHost "foxtrot" rec {
        system = "x86_64-linux";
        user = "harry";
      };

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            end-of-file-fixer.enable = true;
            trim-trailing-whitespace.enable = true;

            nixfmt-rfc-style.enable = true;
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
