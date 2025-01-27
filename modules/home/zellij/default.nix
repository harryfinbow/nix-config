{ config, lib, ... }:

{
  options.modules.zellij = {
    enable = lib.mkEnableOption "enables zellij";
  };

  config = lib.mkIf config.modules.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
