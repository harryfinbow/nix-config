{ config, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [
    localsend
    swaylock
  ];

  flake.modules.darwin."desktop/darwin".imports = with config.flake.modules.darwin; [ aerospace ];

  flake.modules.homeManager."desktop/nixos".imports = with config.flake.modules.homeManager; [
    alacritty
    beansprout
    browser
    foot
    fuzzel
    swayidle
    swaylock
    resources
    wlsunset
  ];

  flake.modules.homeManager."desktop/darwin".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
  ];
}
