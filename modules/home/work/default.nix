{ config, lib, ... }:

{
  options.modules.work = {
    enable = lib.mkEnableOption "enables work";
  };

  config = lib.mkIf config.modules.work.enable {
    age.secrets.git-config = {
      file = ../../../secrets/work.git.age;
      path = "${config.home.homeDirectory}/.config/git/config.work";
    };

    programs.git = {
      userName = lib.mkForce null;
      userEmail = lib.mkForce null;

      extraConfig.url."git@personal.github.com:harryfinbow".insteadOf = "git@github.com:harryfinbow";

      includes = [
        { path = "${config.home.homeDirectory}/.config/git/config.work"; }
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

    programs.ssh = {
      enable = true;
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
