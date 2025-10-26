{ config, lib, ... }:

{
  options.modules.git = {
    enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      settings.user = {
        email = lib.mkDefault "harry@finbow.dev";
        name = lib.mkDefault "Harry Finbow";
      };
    };
  };
}
