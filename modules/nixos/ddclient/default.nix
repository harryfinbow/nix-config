{
  self,
  lib,
  config,
  ...
}:

{

  options.modules.ddclient = {
    enable = lib.mkEnableOption "enables ddclient";
  };

  config = lib.mkIf config.modules.ddclient.enable {
    age.secrets.ddclient.file = (self + "/secrets/ddclient.age");

    services.ddclient = {
      enable = true;
      configFile = config.age.secrets.ddclient.path;
    };
  };
}
