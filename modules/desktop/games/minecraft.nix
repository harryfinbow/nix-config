{
  flake.modules.homeManager.games =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {
      home = {
        packages = with pkgs; [
          prismlauncher
        ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".local/share/PrismLauncher"
        ];
      };
    };
}
