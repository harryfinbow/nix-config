# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ pkgs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/core
    ../common/hardware
    ../common/programs
    ../common/services
  ];

  # Networking
  networking.hostName = "mini";

  # Disable lid switch
  services.logind.lidSwitchExternalPower = "ignore";

  # Enable screen brightness
  programs.light.enable = true;
  services.actkbd.enable = true;
  services.actkbd.bindings = [
    {
      keys = [ 225 ];
      events = [ "key" ];
      command = "/run/current-system/sw/bin/light -A 10";
    }
    {
      keys = [ 224 ];
      events = [ "key" ];
      command = "/run/current-system/sw/bin/light -U 10";
    }
  ];

  # Configure console keymap
  console.keyMap = "uk";

  # Add Ender 3 V2 to Ubuntu dialout group (gid=20)
  services.udev.extraRules = ''
    ACTION=="add",SUBSYSTEM=="tty",ATTRS{idVendor}=="1a86",ATTRS{idProduct}=="7523",GROUP="20"
  '';

  # Uncategorised
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
