{
  self,
  inputs,
  lib,
  config,
  ...
}:
let
  jellyfinDefaultPort = 8096;

  transmissionRPCAddress = config.services.transmission.settings.rpc-bind-address;
  transmissionRPCPort = config.services.transmission.settings.rpc-port;
in
{
  options.modules.nixarr = {
    enable = lib.mkEnableOption "enables nixarr";
  };

  config = lib.mkIf config.modules.nixarr.enable {
    age.secrets.transmission.file = (self + "/secrets/transmission.age");
    age.secrets.vpn.file = (self + "/secrets/vpn.age");

    nixarr = {
      enable = true;
      mediaDir = "/data/media";
      stateDir = "/data/media/.state/nixarr";

      vpn = {
        enable = true;
        wgConf = config.age.secrets.vpn.path;
      };

      transmission = {
        enable = true;
        vpn.enable = true;
        privateTrackers.disableDhtPex = true;
        credentialsFile = config.age.secrets.transmission.path; # Add hostname to `rpc-host-whitelist`
      };

      jellyfin.enable = true;

      jellyseerr.enable = true;

      prowlarr.enable = true;

      radarr.enable = true;

      sonarr.enable = true;
    };

    # VPN Port Forwarding
    # https://protonvpn.com/support/port-forwarding-manual-setup/
    # https://github.com/rasmus-kirk/nixarr/issues/16#issuecomment-2982785699
    # Note: `gateway.ip` should be equal to VPN DNS
    systemd.services.transmission-protonvpn = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "ProtonVPN Transmission Port Forwarding Service";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${inputs.transmission-protonvpn.packages.x86_64-linux.default}/bin/transmission-protonvpn-nat-pmp \
          -transmission.url http://${transmissionRPCAddress}:${toString transmissionRPCPort} \
          -gateway.ip 10.2.0.1 \
          -period 60s \
          -verbose
        '';
      };
    };

    systemd.services.transmission-protonvpn.vpnConfinement = {
      enable = true;
      vpnNamespace = "wg"; # This must be "wg", that's what nixarr uses
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."watch.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString jellyfinDefaultPort}
      '';

      virtualHosts."torrents.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.transmission.uiPort}
      '';

      virtualHosts."radarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.radarr.port}
      '';

      virtualHosts."sonarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.sonarr.port}
      '';

      virtualHosts."prowlarr.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.prowlarr.port}
      '';

      virtualHosts."movies.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.jellyseerr.port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [
        config.nixarr.mediaDir
        config.nixarr.stateDir
      ];
    };
  };
}
