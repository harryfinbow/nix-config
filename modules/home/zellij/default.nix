{ config, lib, ... }:

{
  options.modules.zellij = {
    enable = lib.mkEnableOption "enables zellij";
    autoAttach = lib.mkEnableOption "whether to auto attach to a zellij session";
  };

  config = lib.mkIf config.modules.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = config.modules.zellij.autoAttach;
    };

    xdg.configFile."zellij/config.kdl".source = ./config.kdl;
    xdg.configFile."zellij/layouts/minimal.kdl".source = ./layouts/minimal.kdl;

    home = lib.mkIf config.modules.zellij.autoAttach {
      sessionVariables = {
        ZELLIJ_AUTO_ATTACH = lib.mkForce "true";
        ZELLIJ_AUTO_EXIT = lib.mkForce "true";
      };
    };
  };
}
