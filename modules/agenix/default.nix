topLevel: {
  flake.modules.nixos.agenix =
    { config, ... }:
    {
      imports = [ topLevel.inputs.agenix.nixosModules.default ];

      age.identityPaths = [
        "/persist/${
          config.users.users."${topLevel.config.flake.meta.users.harry.username}".home
        }/.ssh/id_ed25519"
      ];
    };
}
