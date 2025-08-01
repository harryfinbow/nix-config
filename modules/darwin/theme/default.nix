{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.modules.theme.enable {
    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };

        sizes = {
          terminal = 14;
        };
      };

      # https://github.com/danth/stylix/issues/200
      image = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png";
        sha256 = "028bgjzr4q5yhdd4i6ypvk6ch4jjs5qz34ag8b4wcpr835mc37by";
      };
    };
  };
}
