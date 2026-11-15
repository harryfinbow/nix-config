{
  flake.modules.homeManager."desktop/nautilus" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nautilus
        xdg-utils
      ];
    };
}
