{ lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      shell = { program = "${pkgs.fish}/bin/fish"; };
      font.size = lib.mkForce 16; # Move to Stylix
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
      };
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

  programs.git = {
    enable = true;
    userName = lib.mkDefault "Harry Finbow";
    userEmail = lib.mkDefault "harry@finbow.dev";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
