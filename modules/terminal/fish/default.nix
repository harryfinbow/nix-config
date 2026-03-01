topLevel: {
  flake.modules.nixos.terminal =
    { pkgs, ... }:
    {
      programs.fish.enable = true;
      users.users."${topLevel.config.flake.meta.users.harry.username}".shell = pkgs.fish;
    };

  flake.modules.homeManager.terminal =
    {
      config,
      lib,
      options,
      ...
    }:
    {
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

          gc = {
            expansion = "git commit -m \"%\"";
            setCursor = true;
          };
        };
      };

      home = lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".local/share/fish"
        ];
      };
    };
}
