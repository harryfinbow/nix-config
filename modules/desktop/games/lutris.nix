{
  flake.modules.homeManager.games =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ lutris ];
    };
}
