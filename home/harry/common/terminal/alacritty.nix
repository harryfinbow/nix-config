{ pkgs, ... }:

let
  font = "FiraMono Nerd Font";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
      window.opacity = 0.99;
      window.dynamic_padding = true;
      window.padding = {
        x = 10;
        y = 10;
      };
      scrolling.history = 10000;

      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 14;
      };

    };
  };
}
