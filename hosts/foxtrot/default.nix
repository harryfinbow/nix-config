{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Enable additional modules
  modules = {
    impermanence.enable = true;
  };
}
