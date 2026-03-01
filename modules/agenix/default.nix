topLevel: {
  flake.modules.nixos.agenix =
    { config, ... }:
    {
      imports = [ topLevel.inputs.agenix.nixosModules.default ];

      # TODO: Fix this
      age.identityPaths = [
        "/persist/${config.users.users.harry.home}/.ssh/id_ed25519"
      ];
    };

  flake.modules.homeManager.agenix =
    { config, ... }:
    {
      imports = [ topLevel.inputs.agenix.homeManagerModules.default ];

      age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
}
