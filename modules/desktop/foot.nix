{
  flake.modules.homeManager.foot =
    { pkgs, ... }:
    {
      programs.foot = {
        enable = true;
      };
    };
}
