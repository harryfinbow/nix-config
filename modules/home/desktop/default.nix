{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.modules.desktop = {
    enable = lib.mkEnableOption "enables desktop";
  };

  config = lib.mkIf config.modules.desktop.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
