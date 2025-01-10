{ lib, config, currentSystemUser, ... }:

{
  config = {
    users.users."${currentSystemUser}" = {
      initialPassword = "PepsiMax!";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];

      # TODO: Move public keys to `keys` folder
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@dense"
      ];
    };

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };
  };
}