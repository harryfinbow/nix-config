{
  config,
  lib,
  ...
}:

{
  options.modules.actual = {
    enable = lib.mkEnableOption "enables actual";
    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
    };
  };

  config = lib.mkIf config.modules.actual.enable {
    services.actual = {
      enable = true;
      settings.port = config.modules.actual.port;
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."budget.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.actual.port}
      '';
    };

    # TODO: Should this be pointing at /var/lib/private/actual as current value is a symlink?
    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/actual" ];
    };
  };
}
