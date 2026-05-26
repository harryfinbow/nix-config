topLevel: {
  flake.modules.homeManager.beansprout =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      home.packages = [
        topLevel.inputs.beansprout.packages.${system}.default
        pkgs.river
      ];

      xdg.configFile."beansprout/config.kdl".source = ./config.kdl;
    };
}
