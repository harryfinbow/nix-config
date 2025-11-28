{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.modules.hyprland.enable {
    services.mako = {
      enable = true;
      # settings = {

      # };
    };
  };
}
