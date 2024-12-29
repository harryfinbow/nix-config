{ config, lib, ... }:

{
  options.modules.git = {
    enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = lib.mkDefault "Harry Finbow";
      userEmail = lib.mkDefault "harry@finbow.dev";
    };
  };
}
