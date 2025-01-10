{ lib, config, ... }:

{
  options.modules.fish = {
    enable = lib.mkEnableOption "enables fish";
  };

  config = lib.mkIf config.modules.fish.enable {
    programs.fish.enable = true;
  };
}
