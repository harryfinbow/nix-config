{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza # modern ls
    fzf # fuzzy finder
    jq # json processor

    pre-commit # linter

    dooit # todo list
    gh # github cli

    alsa-utils # audio
  ];
}
