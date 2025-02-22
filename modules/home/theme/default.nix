{ config, lib, pkgs, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.modules.theme.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      fonts.sizes = {
        terminal = 14;
      };

      targets = {
        hyprpaper.enable = lib.mkForce false;
      };
    };

    gtk.enable = true;
  };
}
