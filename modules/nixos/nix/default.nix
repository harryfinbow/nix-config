{ lib, config, ... }:

{
  options.nix = {
    enable = lib.mkEnableOption "enables nix";
  };

  config = lib.mkIf config.nix.enable {
    nix.settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
