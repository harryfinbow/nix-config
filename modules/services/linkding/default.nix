topLevel: {
  flake.modules.nixos.linkding =
    {
      config,
      lib,
      options,
      ...
    }:
    let
      dataPath = "/var/lib/containers/linkding/data";
      port = 9090;
    in
    {
      imports = [
        topLevel.config.flake.modules.nixos.agenix
        topLevel.config.flake.modules.nixos.caddy
      ];

      age.secrets.linkding.file = (topLevel.self + "/secrets/linkding.age");

      systemd.tmpfiles.rules = [
        "d ${dataPath} 0700 root root -"
      ];

      services.caddy.virtualHosts."bookmarks.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ dataPath ];
      };

      virtualisation.oci-containers.containers.linkding = {
        image = "sissbruecker/linkding@sha256:12ffd6f3b48c5d46543d2f38030de1f476d8dcff5f486eb75c9c7cb5941e7127"; # v1.42.0
        volumes = [ "${dataPath}:/etc/linkding/data" ];
        ports = [ "${toString port}:9090" ];
        environmentFiles = [ config.age.secrets.linkding.path ];
      };
    };
}
