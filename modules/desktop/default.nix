{ config, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [
    beansprout
    localsend
  ];

  flake.modules.darwin."desktop/darwin".imports = with config.flake.modules.darwin; [ aerospace ];

  flake.modules.homeManager."desktop/nixos".imports = with config.flake.modules.homeManager; [
    alacritty
    beansprout
    browser
    foot
    fuzzel
    resources
  ];

  flake.modules.homeManager."desktop/darwin".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
  ];
}
