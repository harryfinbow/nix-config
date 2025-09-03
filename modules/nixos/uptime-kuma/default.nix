{
  config,
  lib,
  ...
}:

{
  options.modules.uptime-kuma = {
    enable = lib.mkEnableOption "enables uptime-kuma";
    port = lib.mkOption {
      type = lib.types.str;
      default = "3001";
    };
  };

  config = lib.mkIf config.modules.uptime-kuma.enable {
    services.uptime-kuma = {
      enable = true;
      settings.PORT = config.modules.uptime-kuma.port;
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."status.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${config.modules.uptime-kuma.port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/uptime-kuma" ];
    };
  };
}
