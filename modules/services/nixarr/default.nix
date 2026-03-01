{
  lib,
  inputs,
  ...
}:

{
  flake.modules.nixos.nixarr =
    { options, config, ... }:
    {
      imports = [ inputs.nixarr.nixosModules.default ];

      nixarr = {
        enable = true;
        mediaDir = "/data/media";
        stateDir = "/data/media/.state/nixarr";
      };

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [
          config.nixarr.mediaDir
          config.nixarr.stateDir
        ];
      };
    };
}
