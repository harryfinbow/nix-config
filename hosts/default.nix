{ self, inputs, ... }:
let
  specialArgs = { inherit inputs self; };

  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;
in {
  flake = {
    nixosConfigurations = {
      hefty = nixosSystem {
        modules = [ ./hefty ];
        inherit specialArgs;
      };
      mini = nixosSystem {
        modules = [ ./mini ];
        inherit specialArgs;
      };
    };

    darwinConfigurations = {
      dense  = darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./dense ];
        inherit specialArgs;
      };
    };
  };
}
