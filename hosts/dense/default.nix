{ pkgs, ... }:

{
    imports = [ ../common/programs/nix.nix ];

    environment.systemPackages = with pkgs; [
      home-manager

      # Move to home-manager once https://github.com/LnL7/nix-darwin/issues/139 is resolved
      raycast
      obsidian
    ];

    services.yabai = {
      enable = true;
      config = {
        mouse_modifier = "cmd";
        mouse_action1 = "move";
        mouse_action2 = "resize";

        layout              = "bsp";
        top_padding         = 10;
        bottom_padding      = 10;
        left_padding        = 10;
        right_padding       = 10;
        window_gap          = 10;
      };
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;

    services.nix-daemon.enable = true;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    system.stateVersion = 4;
}
