{
  flake.modules.nixos.bluetooth = {
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
  };
}
