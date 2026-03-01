{
  flake.modules.homeManager.desktop =
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
          bitwarden-cli
          bitwarden-desktop
        ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".config/Bitwarden"
        ];
      };
    };
}
