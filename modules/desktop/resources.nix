{
  flake.modules.homeManager.resources =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ resources ];
    };
}
