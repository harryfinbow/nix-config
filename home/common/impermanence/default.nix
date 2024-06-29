{ config, inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/persist/${config.home.homeDirectory}" = {
    directories = [
      ".ssh"
      "Games"
      "git"
    ];
    allowOther = true;
  };
}
