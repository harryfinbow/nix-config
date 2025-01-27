{ config, lib, ... }:

{
  options.modules.starship = {
    enable = lib.mkEnableOption "enables starship";
  };

  config = lib.mkIf config.modules.starship.enable {
    programs.starship = {
      enable = true;

      settings = {
        format = lib.concatStrings [
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

        hostname = {
          ssh_symbol = "";
          format = "[$hostname]($style) ";
          style = "bright-black";
        };

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
  };
}
