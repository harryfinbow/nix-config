{
  flake.modules.homeManager.bitwarden =
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
          # bitwarden-desktop # https://github.com/NixOS/nixpkgs/issues/526914
        ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".config/Bitwarden"
        ];
      };
    };
}
