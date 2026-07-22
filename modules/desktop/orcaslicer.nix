topLevel: {
  flake.modules.nixos.orcaslicer = {
    # https://wiki.bambulab.com/en/general/printer-network-ports
    networking.firewall = {
      allowedUDPPorts = [
        1990
        2021
      ];
    };
  };

  flake.modules.homeManager.orcaslicer =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      home = {
        packages = [ topLevel.inputs.nixpkgs-stable.legacyPackages.${system}.orca-slicer ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".config/OrcaSlicer"
        ];
      };
    };
}
