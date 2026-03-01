{ config, inputs, ... }:
let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  darwinSystem = inputs.nix-darwin.lib.darwinSystem;
in
{
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  flake.nixosConfigurations.nomad = nixosSystem {
    modules = [ config.flake.modules.nixos.nomad ];
    system = "x86_64-linux";
  };

  flake.nixosConfigurations.polaris = nixosSystem {
    modules = [ config.flake.modules.nixos.polaris ];
    system = "x86_64-linux";
  };

  flake.darwinConfigurations.eclipse = darwinSystem {
    modules = [ config.flake.modules.darwin.eclipse ];
    system = "aarch64-darwin";
  };

  flake.nixosConfigurations.node0 = nixosSystem {
    modules = [ config.flake.modules.nixos.node0 ];
    system = "x86_64-linux";
  };
}
