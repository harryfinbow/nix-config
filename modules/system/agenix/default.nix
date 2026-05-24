topLevel: {
  flake.modules.nixos.default =
    {
      config,
      lib,
      options,
      ...
    }:
    let
      identityPath = "${config.users.users.harry.home}/.ssh/id_ed25519";
    in
    {
      imports = [ topLevel.inputs.agenix.nixosModules.default ];

      age.identityPaths =
        if options.environment ? persistence then [ "/persist/${identityPath}" ] else [ "${identityPath}" ];
    };

  flake.modules.homeManager.default =
    { config, ... }:
    {
      imports = [ topLevel.inputs.agenix.homeManagerModules.default ];

      age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    };
}
