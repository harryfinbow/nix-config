{ config, lib, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [
    localsend
    swaylock
  ];

  flake.modules.darwin."desktop/darwin".imports = with config.flake.modules.darwin; [ aerospace ];

  flake.modules.homeManager."desktop/nixos".imports = lib.attrVals [
    "alacritty"
    "beansprout"
    "browser"
    "foot"
    "fuzzel"
    "desktop/nautilus"
    "swayidle"
    "swaylock"
    "resources"
    "wlsunset"
  ] config.flake.modules.homeManager;

  flake.modules.homeManager."desktop/darwin".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
  ];
}
