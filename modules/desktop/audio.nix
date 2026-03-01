{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      services.pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };

      security.rtkit.enable = true;

      environment.systemPackages = with pkgs; [
        alsa-utils # CLI Audio Mixer
        pavucontrol # GUI Audio Mixer
      ];
    };

  flake.modules.homeManager.audio =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {
      home = {
        packages = with pkgs; [
          alsa-utils # CLI Audio Mixer
          pavucontrol # GUI Audio Mixer
        ];
      }
      // lib.optionalAttrs (options.home ? persistence) {
        persistence."/persist".directories = [
          ".local/state/wireplumber"
        ];
      };
    };
}
