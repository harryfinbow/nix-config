{
  flake.modules.homeManager.terminal =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      home = lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".local/share/zoxide"
        ];
      };
    };
}
