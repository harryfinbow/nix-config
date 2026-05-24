topLevel:
let
  username = "harry";
in
{
  flake.modules.nixos.${username} =
    { config, ... }:
    {
      age.secrets.password.file = (topLevel.self + "/secrets/password.age");

      users.users.${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.password.path;

        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };

  flake.modules.homeManager.${username} = {
    home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
    };
  };
}
