{ config, lib, pkgs, ... }:

{
  options.modules.alacritty = {
    enable = lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.modules.alacritty.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        terminal.shell.program = "${pkgs.fish}/bin/fish";
        window = {
          decorations = "none";
          dynamic_padding = true;
          padding = {
            x = 5;
            y = 5;
          };
        };
      };
    };
  };
}
