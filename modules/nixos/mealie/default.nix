{
  config,
  lib,
  ...
}:

{
  options.modules.mealie = {
    enable = lib.mkEnableOption "enables mealie";
    port = lib.mkOption {
      type = lib.types.port;
      default = 9000;
    };
  };

  config = lib.mkIf config.modules.linkding.enable {
    services.mealie = {
      enable = true;
      port = config.modules.mealie.port;
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."meals.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.mealie.port}
      '';
    };

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/mealie" ];
    };
  };
}
