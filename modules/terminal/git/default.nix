topLevel: {
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

  flake.modules.homeManager.work =
    { config, lib, ... }:
    let
      gitConfigPath = "${config.home.homeDirectory}/.config/git/config.work";
    in
    {
      imports = [ topLevel.config.flake.modules.homeManager.agenix ];

      age.secrets.git = {
        file = (topLevel.self + /secrets/git.age);
        path = gitConfigPath;
      };

      programs.git = {
        settings.url."git@personal.github.com:harryfinbow".insteadOf = "git@github.com:harryfinbow";

        includes = [
          { path = gitConfigPath; }
          {
            contents = {
              user = {
                email = "harry@finbow.dev";
              };
            };
            condition = "hasconfig:remote.*.url:git@*:harryfinbow/*";
          }
        ];
      };

    };
}
