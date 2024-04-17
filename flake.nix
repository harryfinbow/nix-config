{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    hyprland.url = "github:hyprwm/Hyprland/v0.38.1";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [ ./home ./hosts ./pre-commit-hooks.nix ];

      systems = [ "x86_64-linux" ];

      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
      };
    };
}
