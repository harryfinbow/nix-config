{ config, ... }:
{
  flake.modules.nixos."desktop/nixos".imports = with config.flake.modules.nixos; [ wayland ];

  flake.modules.darwin."desktop/darwin".imports = with config.flake.modules.darwin; [ aerospace ];

  flake.modules.homeManager."desktop/nixos".imports = with config.flake.modules.homeManager; [
    wayland
    alacritty
    browser
  ];

  flake.modules.homeManager."desktop/darwin".imports = with config.flake.modules.homeManager; [
    alacritty
    browser
  ];
}
