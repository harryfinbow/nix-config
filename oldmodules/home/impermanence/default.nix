{
  config,
  lib,
  ...
}:

{
  options.modules.impermanence = {
    enable = lib.mkEnableOption "enables impermanence";
  };

  config = lib.mkIf config.modules.impermanence.enable {
    home.persistence."/persist/${config.home.homeDirectory}" = {
      directories = [
        ".config/discord"
        ".config/WowUpCf"
        ".local/share/vulkan"
        ".ssh"
        "Games"
        "git"
        "notes"
      ];

      allowOther = true;
    };
  };
}
