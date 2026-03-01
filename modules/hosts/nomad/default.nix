{ config, inputs, ... }:
let
  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "desktop/nixos"
    "games"
    "impermanence"
    "terminal"

    # Users
    "harry"

    # Applications
    "bitwarden"
    "discord"
  ];

  nixosHardwareModules = with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel-cpu-only
    common-gpu-intel-kaby-lake
  ];
in
{
  flake.modules.nixos.nomad =
    { lib, ... }:
    {
      imports =
        map (name: nixosModules.${name}) (lib.filter (name: lib.hasAttr name nixosModules) modules)
        ++ nixosHardwareModules;

      home-manager.users.harry.imports = [ config.flake.modules.homeManager.nomad ];

      networking = {
        hostName = "nomad";
        networkmanager.enable = true;
      };

      # https://wiki.archlinux.org/title/Intel_graphics#Crash/freeze_on_low_power_Intel_CPUs
      boot.kernelParams = [ "i915.enable_dc=0" ];

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      system.stateVersion = "23.11";
    };

  flake.modules.homeManager.nomad =
    { lib, ... }:
    {
      imports = map (name: homeManagerModules.${name}) (
        lib.filter (name: lib.hasAttr name homeManagerModules) modules
      );

      wayland.windowManager.hyprland.settings = {
        monitor = "eDP-1, 1920x1080@60, 0x0, 1.25";
        general = {
          gaps_in = 5;
          gaps_out = 10;
        };
      };

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
