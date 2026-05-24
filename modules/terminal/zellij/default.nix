{
  flake.modules.homeManager.terminal = {
    programs.zellij = {
      enable = true;
    };

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/layouts/minimal.kdl".source = ./layouts/minimal.kdl;
  };
}
