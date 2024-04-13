{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraMono" ]; }) ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = [ "FiraMono" ];
      sansSerif = [ "FiraMono" ];
      monospace = [ "FiraMono" ];
    };
  };
}
