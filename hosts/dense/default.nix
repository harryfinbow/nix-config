{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.agenix.darwinModules.default
    ../common/theme
    ../common/nix
  ];

  # https://github.com/LnL7/nix-darwin/issues/811
  users.users.harryf = {
    home = "/Users/harryf";
    shell = pkgs.bash;
  };

  environment = {
    etc.shells.enable = true; # Allow management of /etc/shells
    shells = [ pkgs.bash pkgs.fish ];
  };

  # Move to home-manager once https://github.com/LnL7/nix-darwin/issues/139 is resolved
  environment.systemPackages = with pkgs; [
    raycast
    obsidian
  ];

  programs.bash.enable = true;
  programs.fish.enable = true;

  services.yabai = {
    enable = true;
    config = {
      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";

      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
  };

  services.nix-daemon.enable = true;

  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.stateVersion = 4;
}
