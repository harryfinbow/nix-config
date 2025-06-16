{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/virtualisation/openstack-config.nix") ];

  modules = {
    audio.enable = false;
    boot.enable = false;
    hyprland.enable = false;
  };

  stylix.targets.grub.enable = false;
}
