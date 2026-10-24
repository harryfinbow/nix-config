{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # System
        btop
        dust
        fastfetch

        # Utilities
        eza
        gh
        jq
        unzip
      ];
    };
}
