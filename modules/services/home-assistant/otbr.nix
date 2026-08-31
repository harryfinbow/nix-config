{
  flake.modules.nixos.home-assistant =
    { lib, ... }:
    {
      # This is defined multiple times at default priority so need to force the value on one of the modules
      boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = lib.mkForce 1;
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
