{
  config,
  inputs,
  lib,
  ...
}:
let
  mkModules = req: all: map (name: all.${name}) (lib.filter (name: lib.hasAttr name all) req);

  nixosModules = config.flake.modules.nixos;
  homeManagerModules = config.flake.modules.homeManager;

  modules = [
    "default"
    "audio"
    "desktop/nixos"
    "games"
    "persistence"
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
  flake.modules.nixos.nomad = {
    imports = (mkModules modules nixosModules) ++ nixosHardwareModules;

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
    { pkgs, ... }:
    {
      imports = mkModules modules homeManagerModules;

      home.packages = with pkgs; [
        brightnessctl
      ];

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
