{ lib, ... }:

{
  stylix = {
    targets.hyprpaper.enable = lib.mkForce false;
  };
}
