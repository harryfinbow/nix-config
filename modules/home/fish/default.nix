{ config, lib, ... }:

{
  options.modules.fish = {
    enable = lib.mkEnableOption "enables fish";
  };

  config = lib.mkIf config.modules.fish.enable {
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
  };
}
