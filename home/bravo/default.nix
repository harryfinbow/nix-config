{ pkgs, ... }:

{

  modules = {
    desktop.enable = false;
    hyprland.enable = false;
    impermanence.enable = false;
    theme.enable = false;
    work.enable = true;
  };

  home = {
    packages = with pkgs; [
      awscli2
      tenv # tfenv for tofu + tfenv
      kubectl
      kustomize
      docker
      colima
      poetry
      eza
      vscode
      pre-commit
      packer
    ];
  };

}
