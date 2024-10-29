{ pkgs, ... }:

{
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
}
