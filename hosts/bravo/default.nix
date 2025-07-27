{
  config,
  inputs,
  pkgs,
  ...
}:

{
  # Move to home-manager once https://github.com/LnL7/nix-darwin/issues/139 is resolved
  environment.systemPackages = with pkgs; [
    raycast
    obsidian
  ];
}
