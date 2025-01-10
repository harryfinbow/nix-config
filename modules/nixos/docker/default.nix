{ lib, config, currentSystemUser, ... }:

{
  options.modules.docker = {
    enable = lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.modules.docker.enable {

    virtualisation.docker.enable = true;

    users.users."${currentSystemUser}".extraGroups = [ "docker" ];

  };
}
