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
        ".config/discord"
        ".config/OrcaSlicer"
        ".config/vesktop"
        ".config/VintagestoryData"
        ".config/WowUpCf"
        ".local/share/fish"
        ".local/share/PrismLauncher"
        ".local/share/vulkan"
        ".local/state/wireplumber"
        ".local/share/zoxide"
        ".librewolf"
        ".mozilla"
        ".runelite"
        ".ssh"
        ".zen" # TODO: Remove this at some point
        "Games"
        "git"
        "notes"

        # Steam Games
        ".config/unity3d/Ludeon Studios/RimWorld by Ludeon Studios" # Rimworld
        ".config/unity3d/Team Cherry/Hollow Knight" # Hollow Knight
        ".factorio" # Factorio

        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];

      allowOther = true;
    };
  };
}
