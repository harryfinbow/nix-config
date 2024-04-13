{
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true; # Deduplicate and optimize nix store
  };

  nixpkgs.config.allowUnfree = true;
}
