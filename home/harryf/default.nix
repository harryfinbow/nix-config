{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../common
    ../common/terminal.nix
  ];

  home = {
    username = "harryf";
    homeDirectory = "/Users/harryf";

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
    ];
  };

  programs.git = {
    userName = lib.mkForce null;
    userEmail = lib.mkForce null;

    extraConfig.url."git@personal.github.com:harryfinbow".insteadOf =
      "git@github.com:harryfinbow";

    includes = [
      { path = "/Users/harryf/.config/git/config.work"; }
      {
        contents = { user = { email = "harry@finbow.dev"; }; };
        condition = "hasconfig:remote.*.url:git@github.com:harryfinbow/*";
      }
    ];
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "personal.github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/personal.github.com";
      };
    };
  };
}
