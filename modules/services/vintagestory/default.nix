topLevel: {
  flake.modules.nixos.vintagestory =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.inputs.vs2nix.nixosModules.default ];

      services.vintagestory = {
        enable = true;
        openFirewall = true;
      };

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          "/var/lib/${toString config.services.vintagestory.dataPath}"
        ];
      };
    };
}
