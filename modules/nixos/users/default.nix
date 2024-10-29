{ lib, config, ... }:

{
  options.modules.users = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "harry";
    };
  };

  config = {
    users.users."${config.modules.users.name}" = {
      initialPassword = "PepsiMax!";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
    };
  };
}
