{ inputs, ... }: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/openstack-config.nix"

    ../common
    ../common/nix
    ../common/ssh
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
