{ config, lib, ... }:

{
  options.modules.zoxide = {
    enable = lib.mkEnableOption "enables zoxide";
  };

  config = lib.mkIf config.modules.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
