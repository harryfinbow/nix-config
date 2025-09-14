{
  self,
  config,
  lib,
  ...
}:

{
  options.modules.linkding = {
    enable = lib.mkEnableOption "enables linkding";
    port = lib.mkOption {
      type = lib.types.port;
      default = 9090;
    };
  };

  config = lib.mkIf config.modules.linkding.enable {
    age.secrets.linkding.file = (self + "/secrets/linkding.age");

    systemd.tmpfiles.rules = [
      "d /var/lib/containers/linkding/data 0700 root root -"
    ];

    virtualisation.oci-containers.containers.linkding = {
      image = "sissbruecker/linkding@sha256:12ffd6f3b48c5d46543d2f38030de1f476d8dcff5f486eb75c9c7cb5941e7127"; # v1.42.0
      volumes = [ "/var/lib/containers/linkding/data:/etc/linkding/data" ];
      ports = [ "${toString config.modules.linkding.port}:9090" ];
      environmentFiles = [ config.age.secrets.linkding.path ];
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."bookmarks.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.linkding.port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/containers/linkding" ];
    };
  };
}
