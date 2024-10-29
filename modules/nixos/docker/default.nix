{ lib, config, ... }:

{
  options.modules.docker = {
    enable = lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.modules.docker.enable {

    virtualisation.docker.enable = true;

    users.users."${config.modules.users.name}".extraGroups = [ "docker" ];

  };
}
