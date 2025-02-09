{ lib, config, ... }:

{

  options.modules.aerospace = {
    enable = lib.mkEnableOption "enables aerospace";
  };

  config = lib.mkIf config.modules.aerospace.enable {
    services.aerospace.enable = true;
  };
}
