{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.modules.sunshine = {
    enable = lib.mkEnableOption "enables sunshine";
  };

  config = lib.mkIf config.modules.sunshine.enable {
    services.sunshine = {
      enable = true;
      openFirewall = true;
      applications = {
        apps = [
          {
            name = "MoonDeckStream";
            cmd = "${pkgs.moondeck-buddy}/bin/MoonDeckStream";
            exclude-global-prep-cmd = "false";
            elevated = "false";
          }
        ];
      };
    };

    # MoonDeck Buddy
    networking.firewall.allowedTCPPorts = [ 59999 ];

    # xdg.autostart.entries = [ "${pkgs.moondeck-buddy}/share/applications/MoonDeckBuddy.desktop" ];
  };
}
