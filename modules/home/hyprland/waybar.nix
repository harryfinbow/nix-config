{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.modules.hyprland.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        main-bar = {
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "temperature"
            "network"
            "pulseaudio"
            "clock"
          ];

          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              active = " ";
            };
          };

          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:%Y-%m-%d}";
          };

          network = {
            format = "{ifname}";
            format-wifi = "  {signalStrength}%";
            format-ethernet = " ";
            format-disconnected = "Not connected";
            tooltip-format = "  {ifname} via {gwaddri}";
            tooltip-format-wifi = "  {essid} ({signalStrength}%)";
            tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
            tooltip-format-disconnected = "Disconnected";
            interval = 15; # Update every 15 seconds
          };

          temperature = {
            hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input"; # CPU Temperature
            format = " {temperatureC}°C";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "";
            format-icons = {
              default = [
                ""
                ""
              ];
            };
            scroll-step = 1;
            on-click = "pavucontrol";
            ignored-sinks = [ "Easy Effects Sink" ];
          };
        };
      };
    };
  };
}
