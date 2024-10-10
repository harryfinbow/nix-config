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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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

  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        # "$nix_shell"
        "$python"
        "$line_break"
        "$character"
      ];

      directory = {
        style = "blue";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style) ";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };

      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };

      # nix_shell = {
      #   format = "[$symbol]($style) ";
      #   symbol = "❄️";
      #   heuristic = true;
      # };

      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
