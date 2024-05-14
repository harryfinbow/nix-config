{ self, inputs, ... }:
let
  extraSpecialArgs = { inherit inputs self; };
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  flake = {
    homeConfigurations = {
      "harry@hefty" = homeManagerConfiguration {
        modules = [ ./harry/hefty.nix ];
        inherit pkgs extraSpecialArgs;
      };
      "harry@mini" = homeManagerConfiguration {
        modules = [ ./harry/mini.nix ];
        inherit pkgs extraSpecialArgs;
      };
      "harryf@harryf-malt0" = homeManagerConfiguration {
	pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./harryf/harryf-malt0.nix ];
        inherit extraSpecialArgs;
      };
    };
  };
}
