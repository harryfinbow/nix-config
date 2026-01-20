{
  config,
  currentSystemUser,
  ...
}:
let
  identityFilePath =
    if config.modules.impermanence.enable then
      "/persist/${config.users.users."${currentSystemUser}".home}/.ssh/id_ed25519"
    else
      "${config.users.users."${currentSystemUser}".home}/.ssh/id_ed25519";
in
{
  config = {
    age.secrets.password.file = ../../../secrets/password.age;

    users = {
      users."${currentSystemUser}" = {
        isNormalUser = true;
        hashedPasswordFile = config.age.secrets.password.path;

        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
        ];

        # TODO: Move public keys to `keys` folder
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G harry@foxtrot"
        ];
      };
      mutableUsers = false;
    };

    age.identityPaths = [ identityFilePath ];

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    security.sudo.wheelNeedsPassword = false;
  };
}
