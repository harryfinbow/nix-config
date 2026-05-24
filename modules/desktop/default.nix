{ config, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [
    helium
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
    helium
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
