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
    };

    nixpkgs.config.allowUnfree = true;
  };
}
