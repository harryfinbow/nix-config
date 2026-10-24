{
  flake.modules.homeManager.terminal =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      programs.nushell = {
        enable = true;

        shellAliases = {
          e = "hx";

          # TODO: Sort by type/name by default (e.g. `ls = "ls | sort-by type"`)
          ll = "ls -a";
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

        settings = {
          history = {
            file_format = "sqlite";
            isolation = false;
          };

          # Theme
          table.mode = "single";

          # TODO: Migrate to `helix` mode
          edit_mode = "emacs";
        };

        extraConfig = ''
          $env.config.max_last_result_size = 1mb
          $env.config.history.path = $"($nu.data-dir)/history.sqlite3"
          $env.LS_COLORS = (vivid generate catppuccin-frappe)
        '';
      };

      home = lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".local/share/nushell"
        ];
      };
    };
}
