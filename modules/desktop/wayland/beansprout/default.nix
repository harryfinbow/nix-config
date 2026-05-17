topLevel: {
  flake.modules.nixos.beansprout =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = [
        topLevel.inputs.beansprout.packages.${system}.default
        pkgs.river
      ];
    };

  flake.modules.homeManager.beansprout = {
    xdg.configFile."beansprout/config.kdl".source = ./config.kdl;
  };
}
