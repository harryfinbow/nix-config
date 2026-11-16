{
  flake.modules.homeManager.dolphin =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        kdePackages.dolphin
        kdePackages.kio
        xdg-utils
      ];
    };
}
