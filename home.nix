{ config, ... }:

{
  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      "Games"
    ];
    allowOther = true;
  };

  home.stateVersion = "23.11";
}
