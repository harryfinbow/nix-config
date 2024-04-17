{ pkgs, config, ... }:

{
  imports = [ ./fish.nix ./fonts.nix ./hyprland.nix ./nix.nix ];

  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique =
      builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in formatted;

}
