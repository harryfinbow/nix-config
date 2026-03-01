topLevel: {
  flake.modules.nixos.vm0 = {
    imports = with topLevel.config.flake.modules.nixos; [
      default

      # Services
      vintagestory
    ];

    networking.hostName = "vm0";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
  };
}
