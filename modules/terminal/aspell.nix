{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (aspellWithDicts (dicts: with dicts; [ en ]))
      ];
    };
}
