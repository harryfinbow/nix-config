{ pkgs, ... }:

{
  imports = [
    ./default.nix
  ];

  home.packages = with pkgs; [
    awscli2
    tenv # tfenv for tofu + tfenv
    kubectl
    docker
    colima
    poetry
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.fish}/bin/fish";
      };
      window.decorations = "none";
      font.size = 16;
    };
  };

  programs.fish.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "personal.github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/personal.github.com";
      };
    };
  };

  programs.git = {
    enable = true;

    userName = "Harry Finbow";
    userEmail = builtins.getEnv "GIT_EMAIL";

    extraConfig.url."git@personal.github.com:harryfinbow".insteadOf = "git@github.com:harryfinbow";

    includes = [
      {
        contents = {
          user = {
            email = "harry@finbow.dev";
          };
        };

        condition = "hasconfig:remote.*.url:git@github.com:harryfinbow/*";
      }
    ];
  };
}
