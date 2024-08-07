{ config, inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      ".config/discord"
      ".local/share/fish"
      ".local/share/zoxide"
      ".mozilla"
      ".ssh"
      "Games"
      "git"

      { directory = ".local/share/Steam"; method = "symlink"; }
    ];

    allowOther = true;
  };
}
