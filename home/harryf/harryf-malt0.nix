{pkgs, ... }:

{
  imports = [
    ./default.nix
    ../common/terminal/git.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
      font.size = 16;
    };
  };
}
