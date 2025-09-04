{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.orcaslicer = {
    enable = lib.mkEnableOption "enables orcaslicer";
  };

  config = lib.mkIf config.modules.orcaslicer.enable {
    environment.systemPackages = with pkgs; [
      orca-slicer
    ];

    # https://wiki.bambulab.com/en/general/printer-network-ports
    networking.firewall = {
      allowedUDPPorts = [
        1990
        2021
      ];
    };
  };
}
