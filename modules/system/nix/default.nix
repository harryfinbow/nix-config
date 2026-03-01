{
  flake.modules.nixos.default = {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
        use-xdg-base-directories = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
