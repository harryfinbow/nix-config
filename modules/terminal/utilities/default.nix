{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # System
        neofetch
        btop

        # Utilities
        jq
        eza
      ];
    };
}
