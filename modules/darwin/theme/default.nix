{ lib, config, ... }:

{
  options.modules.theme = {
    enable = lib.mkEnableOption "enables theme";
  };

  config = lib.mkIf config.modules.theme.enable {
    stylix = {
      enable = true;
    };
  };
}
