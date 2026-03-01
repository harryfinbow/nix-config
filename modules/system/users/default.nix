topLevel:

let
  username = topLevel.config.flake.meta.users.harry.username;
in
{
  flake.meta.users.harry = {
    username = "harry";
  };

  flake.modules.nixos.default =
    { config, self, ... }:
    {
      imports = [ topLevel.config.flake.modules.nixos.agenix ];

      age.secrets.password.file = (self + "/secrets/password.age");

      users.users.${username} = {
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.password.path;

        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      time.timeZone = "Europe/London";
      i18n.defaultLocale = "en_GB.UTF-8";
    };

  flake.modules.home.default =
    { pkgs, ... }:
    {
      home = {
        username = "${username}";
        homeDirectory = if pkgs.stdenvNoCC.isDarwin then "/Users/${username}" else "/home/${username}";
      };
    };
}
