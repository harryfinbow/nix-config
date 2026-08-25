{
  flake.modules.nixos.home-assistant = {
    services.openthread-border-router = {
      enable = true;
      openFirewall = true;
      backboneInterfaces = [ "enp1s0" ];
      radio = {
        device = "/dev/serial/by-id/usb-Itead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_V2_d2317d1da4f3ef119cd0c51b6d9880ab-if00-port0";
        baudRate = 460800;
        flowControl = false;
      };
      web = {
        enable = true;
        listenAddress = "0.0.0.0";
      };
    };
  };
}
