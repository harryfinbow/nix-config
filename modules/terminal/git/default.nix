{
  flake.modules.homeManager.terminal =
    { lib, ... }:
    {
      programs.git = {
        enable = true;
        settings.user = {
          email = lib.mkDefault "harry@finbow.dev";
          name = lib.mkDefault "Harry Finbow";
        };
      };
    };
}
