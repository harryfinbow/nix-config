topLevel: {
  flake.modules.homeManager.terminal =
    let
      remote = topLevel.flake.meta.remote or false;
    in
    {
      programs.zellij = {
        enable = true;

        # Only enable auto-attach on remote machines
        enableFishIntegration = remote;
        attachExistingSession = remote;
        exitShellOnExit = remote;
      };

      xdg.configFile."zellij/config.kdl".source = ./config.kdl;
      xdg.configFile."zellij/layouts/minimal.kdl".source = ./layouts/minimal.kdl;
    };
}
