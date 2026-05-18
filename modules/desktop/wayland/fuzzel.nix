{
  flake.modules.homeManager.fuzzel =
    { lib, pkgs, ... }:
    {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = lib.getExe' pkgs.foot "foot";
            vertical-pad = 8;
            horizontal-pad = 8;
            image-size-ratio = 1; # Disable larger images
          };
          border.radius = 0;
        };
      };
    };
}
