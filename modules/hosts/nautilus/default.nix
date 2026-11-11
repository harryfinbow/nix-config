topLevel:
let
  mkModules =
    req: all: map (name: all.${name}) (topLevel.lib.filter (name: topLevel.lib.hasAttr name all) req);

  nixosModules = topLevel.config.flake.modules.nixos;
  homeManagerModules = topLevel.config.flake.modules.homeManager;

  modules = [
    "default"
    "ssh"
    "terminal"
    "work"

    # Users
    "harry"
  ];
in
{
  flake.modules.nixos.nautilus =
    {
      config,
      modulesPath,
      lib,
      ...
    }:
    {
      imports = (mkModules modules nixosModules) ++ [
        (modulesPath + "/virtualisation/openstack-config.nix")
      ];

      home-manager.users.harry.imports = [ topLevel.config.flake.modules.homeManager.nautilus ];

      networking.hostName = "nautilus";

      nixpkgs.hostPlatform = "x86_64-linux";

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      system.stateVersion = "23.11";

      virtualisation.containers.storage.settings.storage.graphroot = "/ephemeral/container-storage";

      services.fail2ban.enable = lib.mkForce false;

      # Required for Buildstream
      programs.fuse.enable = true;

      # Boot
      boot.loader.systemd-boot.enable = lib.mkForce false;
      stylix.targets.grub.enable = false;
    };

  flake.modules.homeManager.nautilus =
    { lib, ... }:
    {
      imports = mkModules modules homeManagerModules;

      programs.zellij = {
        enableFishIntegration = true;
        attachExistingSession = true;
        exitShellOnExit = true;
      };

      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      home.stateVersion = "23.11";
    };
}
