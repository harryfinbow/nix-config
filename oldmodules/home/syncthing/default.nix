{
  config,
  lib,
  ...
}:

{
  options.modules.syncthing = {
    enable = lib.mkEnableOption "enables syncthing";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8384;
    };
  };

  config = lib.mkIf config.modules.syncthing.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "localhost:${toString config.modules.syncthing.port}";
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."sync.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.syncthing.port}
      '';
    };

    home.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/syncthing" ];
    };
  };
}
