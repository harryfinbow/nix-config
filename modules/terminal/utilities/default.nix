{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # System
        fastfetch
        btop

        # Utilities
        jq
        eza
      ];
    };
}
