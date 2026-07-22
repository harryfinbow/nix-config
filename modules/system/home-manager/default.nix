topLevel:
let
  homeManagerModule =
    { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
in
{
  flake.modules.nixos.default = {
    imports = [
      topLevel.inputs.home-manager.nixosModules.home-manager
      homeManagerModule
    ];
  };

  flake.modules.darwin.default = {
    imports = [
      topLevel.inputs.home-manager.darwinModules.home-manager
      homeManagerModule
    ];
  };
}
