{ pkgs, ... }:

{
  imports = [ ../common/wayland ];

  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.packages = with pkgs; [ jq eza ];

  programs.alacritty = {
    enable = true;

    settings = {
      shell = { program = "${pkgs.fish}/bin/fish"; };
      font.size = 16;
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
    userName = "Harry Finbow";
    userEmail = "harry@finbow.dev";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Let `home-manager` manage itself
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}