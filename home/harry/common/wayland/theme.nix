{ inputs, ... }:

{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin.flavour = "macchiato";

  xdg.enable = true;

  gtk = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.waybar.catppuccin.enable = true;
}
