{ config, inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      ".config/Bitwarden"
      ".config/vesktop"
      ".config/WowUpCf"
      ".local/share/fish"
      ".local/share/vulkan"
      ".local/share/zoxide"
      ".local/state/wireplumber"
      ".mozilla"
      ".runelite"
      ".ssh"
      ".zen"
      "Games"
      "git"

      { directory = ".local/share/Steam"; method = "symlink"; }
    ];

    allowOther = true;
  };
}
