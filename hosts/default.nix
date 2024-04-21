{ self, inputs, ... }:
let
  specialArgs = { inherit inputs self; };

  inherit (inputs.nixpkgs.lib) nixosSystem;
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
  };
}
