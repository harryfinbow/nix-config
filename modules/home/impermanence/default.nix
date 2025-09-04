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
        ".config/Bitwarden"
        ".config/vesktop"
        ".config/VintagestoryData"
        ".config/WowUpCf"
        ".local/share/fish"
        ".local/share/vulkan"
        ".local/share/zoxide"
        ".local/state/wireplumber"
        ".librewolf"
        ".mozilla"
        ".runelite"
        ".ssh"
        ".zen" # TODO: Remove this at some point
        "Games"
        "git"

        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];

      allowOther = true;
    };
  };
}
