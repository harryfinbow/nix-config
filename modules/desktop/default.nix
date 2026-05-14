{ config, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [
    hyprland
    beansprout
  ];

  flake.modules.darwin."desktop/darwin".imports = with config.flake.modules.darwin; [ aerospace ];

  flake.modules.homeManager."desktop/nixos".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
    hyprland
    foot
  ];

  flake.modules.homeManager."desktop/darwin".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
  ];
}
