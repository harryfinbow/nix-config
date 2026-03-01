{
  flake.modules.nixos.games =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
    };

  flake.modules.homeManager.steam =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      home = lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          {
            directory = ".local/share/Steam";
            method = "symlink";
          }

          # Steam Games
          ".config/unity3d/Ludeon Studios/RimWorld by Ludeon Studios" # Rimworld
          ".config/unity3d/Team Cherry/Hollow Knight" # Hollow Knight
          ".factorio" # Factorio
        ];
      };
    };
}
