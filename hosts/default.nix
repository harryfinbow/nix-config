{ self, inputs, ... }:
let
  specialArgs = {
    inherit inputs self;
    pkgs-small = import inputs.nixpkgs-small {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };

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
