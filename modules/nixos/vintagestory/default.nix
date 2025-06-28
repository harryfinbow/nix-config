{ lib, config, ... }:

{

  options.modules.vintagestory = {
    enable = lib.mkEnableOption "enables vintagestory";
  };

  config = lib.mkIf config.modules.vintagestory.enable {
    services.vintagestory = {
      enable = true;
      openFirewall = true;
    };
  };
}
