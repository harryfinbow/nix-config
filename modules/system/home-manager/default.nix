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

  flake.modules.homeManager.default = {
    # evaluation warning: The default value of `gtk.gtk4.theme` has changed from `config.gtk.theme` to `null`.
    # You are currently using the legacy default (`config.gtk.theme`) because `home.stateVersion` is less than "26.05".
    gtk.gtk4.theme = null;
  };
}
