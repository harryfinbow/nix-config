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
    star-citizen.enable = true;
    steam.enable = true;
    logitech.enable = true;
    nvidia.enable = true;
    orcaslicer.enable = true;
  };

  # TODO: Why did I add this?
  security.polkit.enable = true;

  # Required for Vintage Story
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];
}
