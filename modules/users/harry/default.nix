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

        # TODO: Work out a better way to do this
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G harry@foxtrot"
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
