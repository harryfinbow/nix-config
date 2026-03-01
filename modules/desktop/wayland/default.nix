{
  flake.modules.nixos.wayland = {
    xdg.portal.enable = true;

    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
      };
    };
  };

  flake.modules.homeManager.wayland =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brightnessctl
        wl-clipboard
      ];

      programs.rofi = {
        enable = true;
      };

      services.wlsunset = {
        enable = true;
        latitude = "51.51";
        longitude = "0.13";
        temperature = {
          day = 6500;
          night = 3000;
        };
      };
    };
}
