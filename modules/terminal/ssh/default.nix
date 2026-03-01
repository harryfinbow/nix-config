{
  flake.modules.homeManager.work = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "personal.github.com" = {
          hostname = "github.com";
          identityFile = "~/.ssh/personal.github.com";
        };
        "personal.gitlab.com" = {
          hostname = "gitlab.com";
          identityFile = "~/.ssh/personal.gitlab.com";
        };
      };
    };
  };
}
