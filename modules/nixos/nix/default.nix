{ lib, config, ... }:

{
  options.modules.nix = {
    enable = lib.mkEnableOption "configures nix";
  };

  config = lib.mkIf config.modules.nix.enable {
    nix.settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
