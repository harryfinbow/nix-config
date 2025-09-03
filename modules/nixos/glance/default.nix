{
  config,
  lib,
  ...
}:

{
  options.modules.glance = {
    enable = lib.mkEnableOption "enables glance";
    port = lib.mkOption {
      type = lib.types.port;
      default = 3333;
    };
  };

  config = lib.mkIf config.modules.glance.enable {
    services.glance = {
      enable = true;
      settings.server.port = config.modules.glance.port;
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."start.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.glance.port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/glance" ];
    };
  };
}
