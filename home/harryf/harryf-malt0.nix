{ pkgs, ... }:

{
  imports = [ ./default.nix ];

  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    awscli2
    tenv # tfenv for tofu + tfenv
    kubectl
    kustomize
    docker
    colima
    poetry
    eza
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      shell = { program = "${pkgs.fish}/bin/fish"; };
      window.decorations = "none";
      font.size = 16;
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
    };
    shellAbbrs = {
      ls = "eza";
      ll = "eza -la";
      cdr = "cd (git rev-parse --show-toplevel)";

      k = "kubectl";
      ka = "kubectl apply";
      kd = "kubectl describe";
      kg = "kubectl get";

      gl = "git log --oneline -n 15";
      gs = "git status";
      gsw = "git switch";
      gr = "git rebase";
      gro = "git rebase origin/main";
      gru = "git remote update";
    };
    plugins = [{
      name = "pure";
      src = pkgs.fishPlugins.pure.src;
    }];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.neovim = { enable = true; };

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

    extraConfig.url."git@personal.github.com:harryfinbow".insteadOf =
      "git@github.com:harryfinbow";

    includes = [{
      contents = { user = { email = "harry@finbow.dev"; }; };

      condition = "hasconfig:remote.*.url:git@github.com:harryfinbow/*";
    }];
  };
}
