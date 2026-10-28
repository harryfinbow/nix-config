{ config, inputs, ... }:
let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  darwinSystem = inputs.nix-darwin.lib.darwinSystem;
in
{
  flake.nixosConfigurations.nomad = nixosSystem {
    modules = [ config.flake.modules.nixos.nomad ];
  };

  flake.nixosConfigurations.polaris = nixosSystem {
    modules = [ config.flake.modules.nixos.polaris ];
  };

  flake.darwinConfigurations.eclipse = darwinSystem {
    modules = [ config.flake.modules.darwin.eclipse ];
  };

  flake.nixosConfigurations.node0 = nixosSystem {
    modules = [ config.flake.modules.nixos.node0 ];
  };

  flake.nixosConfigurations.node1 = nixosSystem {
    modules = [ config.flake.modules.nixos.node1 ];
  };
}
