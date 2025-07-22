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

      extraOptions = ''
        extra-substituters = https://devenv.cachix.org
        extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
      '';
    };

    nixpkgs.config.allowUnfree = true;
  };
}
