{
  config,
  lib,
  currentSystemUser,
  ...
}:
let
  # homeDirectory = config.users.users.${currentSystemUser}.home;
  homeDirectory = "/home/harry";
in
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
      user = currentSystemUser;
      dataDir = homeDirectory;
      guiAddress = "localhost:${toString config.modules.syncthing.port}";
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."sync.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.syncthing.port}
      '';
    };

    # environment.persistence = lib.mkIf config.modules.impermanence.enable {
    #   "/persist/system".directories = [
    #     "${config.services.syncthing.dataDir}"
    #   ];
    # };
  };
}
