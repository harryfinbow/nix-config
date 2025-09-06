{
  self,
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
    age.secrets.glance.file = (self + "/secrets/glance.age");

    services.glance = {
      enable = true;
      settings = {
        server.port = config.modules.glance.port;
        pages = [
          {
            name = "Home";
            columns = [
              {
                size = "small";
                widgets = [
                  { type = "calendar"; }
                  {
                    type = "monitor";
                    cache = "1m";
                    title = "Services";
                    style = "compact";
                    sites = [
                      {
                        title = "Actual";
                        url = "https://budget.\${BASE_DOMAIN}";
                        icon = "si:actualbudget";
                      }
                      {
                        title = "Caddy";
                        url = "https://health.\${BASE_DOMAIN}";
                        icon = "si:caddy";
                      }
                      {
                        title = "Prowlarr";
                        url = "https://indexers.\${BASE_DOMAIN}";
                        icon = "si:prowlarr";
                      }
                      {
                        title = "Radarr";
                        url = "https://movies.\${BASE_DOMAIN}";
                        icon = "si:radarr";
                      }
                      {
                        title = "Transmission";
                        url = "https://torrents.\${BASE_DOMAIN}";
                        icon = "si:transmission";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "group";
                    widgets = [
                      { type = "lobsters"; }
                      { type = "hacker-news"; }
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "reddit";
                        subreddit = "selfhosted";
                      }
                      {
                        type = "reddit";
                        subreddit = "homelab";
                        show-thumbnails = true;
                      }
                      {
                        type = "reddit";
                        subreddit = "minilab";
                        show-thumbnails = true;
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "weather";
                    location = "\${LOCATION}";
                    units = "metric";
                    hour-format = "24h";
                  }
                  {
                    type = "server-stats";
                    servers = [
                      {
                        type = "local";
                        name = "Delta";
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };

    services.caddy = lib.mkIf config.modules.caddy.enable {
      virtualHosts."start.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.modules.glance.port}
      '';
    };

    systemd.services.glance.serviceConfig.EnvironmentFile = [ config.age.secrets.glance.path ];

    environment.persistence = lib.mkIf config.modules.impermanence.enable {
      "/persist/system".directories = [ "/var/lib/glance" ];
    };
  };
}
