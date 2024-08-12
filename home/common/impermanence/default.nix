{ config, inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      ".config/vesktop"
      ".local/share/fish"
      ".local/share/zoxide"
      ".mozilla"
      ".runelite"
      ".ssh"
      "Games"
      "git"

      { directory = ".local/share/Steam"; method = "symlink"; }
    ];

    allowOther = true;
  };
}
