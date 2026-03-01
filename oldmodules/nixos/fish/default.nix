{
  pkgs,
  lib,
  config,
  currentSystemUser,
  ...
}:

{
  options.modules.fish = {
    enable = lib.mkEnableOption "enables fish";
  };

  config = lib.mkIf config.modules.fish.enable {
    programs.fish.enable = true;

    users.users."${currentSystemUser}".shell = pkgs.fish;
  };
}
