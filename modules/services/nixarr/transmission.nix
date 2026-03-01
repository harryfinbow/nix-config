topLevel: {
  flake.modules.nixos.nixarr =
    {
      self,
      config,
      ...
    }:
    {
      imports = [
        topLevel.config.flake.modules.nixos.agenix
        topLevel.config.flake.modules.nixos.caddy
      ];

      age.secrets.transmission.file = (topLevel.self + "/secrets/transmission.age");

      nixarr.transmission = {
        enable = true;
        vpn.enable = true;
        privateTrackers.disableDhtPex = true;
        credentialsFile = config.age.secrets.transmission.path; # Add hostname to `rpc-host-whitelist`
      };

      services.caddy.virtualHosts."torrents.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.nixarr.transmission.uiPort}
      '';
    };
}
