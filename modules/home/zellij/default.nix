{ config, lib, ... }:

{
  options.modules.zellij = {
    enable = lib.mkEnableOption "enables zellij";
    remote = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = config.modules.zellij.remote;
    };

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;

    home = lib.mkIf config.modules.zellij.remote {
      sessionVariables = {
        ZELLIJ_AUTO_ATTACH = "true";
        ZELLIJ_AUTO_EXIT = "true";
      };
    };
  };
}
