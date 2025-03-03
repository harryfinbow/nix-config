{ lib, config, ... }:

{
  options.modules.nix = {
    enable = lib.mkEnableOption "configures nix";
  };

  config = lib.mkIf config.modules.nix.enable {
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
