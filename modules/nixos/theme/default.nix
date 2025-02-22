{ pkgs, lib, config, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.modules.theme.enable {
    stylix = {
      enable = true;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };
      };

      cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
      };

      # https://github.com/danth/stylix/issues/200
      image = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png";
        sha256 = "028bgjzr4q5yhdd4i6ypvk6ch4jjs5qz34ag8b4wcpr835mc37by";
      };
    };
  };
}
