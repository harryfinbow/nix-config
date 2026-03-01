{ config, inputs, ... }:

{
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.node0 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.home-manager.nixosModules.home-manager
      config.flake.modules.nixos.node0

      # TODO: Move to module
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${config.flake.meta.users.harry.username}.imports = [
            config.flake.modules.homeManager.node0
          ];
        };
      }
    ];
  };

  flake.nixosConfigurations.vm0 = inputs.nixpkgs.lib.nixosSystem {
    modules = [ config.flake.modules.nixos.vm0 ];
    system = "x86_64-linux";
  };
}
