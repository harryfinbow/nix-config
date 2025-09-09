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

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported Bluetooth adapters
        Experimental = true;
        # When enabled other devices can connect faster to us, however the tradeoff is increased power consumption
        FastConnectable = true;
      };
    };
  };

  # Bluetooth GUI
  services.blueman.enable = true;

  # TODO: Why did I add this?
  security.polkit.enable = true;

  # Required for Vintage Story
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];
}
