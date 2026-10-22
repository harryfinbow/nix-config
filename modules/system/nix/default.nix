let
  nixModule =
    { pkgs, ... }:
    {
      nix = {
        settings = {
          auto-optimise-store = true;
          use-xdg-base-directories = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };

        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        }
        // (
          if pkgs.stdenv.hostPlatform.isDarwin then
            {
              interval = {
                Weekday = 0;
                Hour = 0;
                Minute = 0;
              };
            }
          else
            { dates = "weekly"; }
        );
      };

      nixpkgs.config.allowUnfree = true;
    };
in
{
  flake.modules.nixos.default.imports = [ nixModule ];
  flake.modules.darwin.default.imports = [ nixModule ];
}
