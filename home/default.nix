{ self, inputs, ... }:
let
  # get these into the module system
  extraSpecialArgs = { inherit inputs self; };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  flake = {
    homeConfigurations = {
      "harry@hefty" = homeManagerConfiguration {
        modules = [ ./harry/hefty.nix ];
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
