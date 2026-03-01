{
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
    {
      home = {
        packages = with pkgs; [ orca-slicer ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".config/OrcaSlicer"
        ];
      };
    };
}
