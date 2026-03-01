{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.steam = {
    enable = lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
