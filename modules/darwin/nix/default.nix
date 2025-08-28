{ lib, config, ... }:

{
  options.modules.nix = {
    enable = lib.mkEnableOption "configures nix";
  };

  config = lib.mkIf config.modules.nix.enable {
    nix = {
      optimise.automatic = true;
      settings = {
        experimental-features = "nix-command flakes";
        use-xdg-base-directories = true;
      };

      extraOptions = ''
        extra-substituters = https://devenv.cachix.org
        extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
      '';
    };

    nixpkgs.config.allowUnfree = true;
  };
}
