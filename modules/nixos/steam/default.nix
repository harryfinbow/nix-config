{ pkgs, lib, config, ... }:

{
  options.modules.steam = {
    enable = lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.modules.steam.enable {
    environment.sessionVariables = {
      MANGOHUD = 1;
    };

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
