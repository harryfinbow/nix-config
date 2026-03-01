topLevel: {
  flake.modules.nixos.glance =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      imports = [ topLevel.config.flake.modules.nixos.caddy ];

      services.caddy.virtualHosts."start.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.glance.settings.server.port}
      '';

      # TODO: Is Glance stateless? Do we need to persist any data?
      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ "/var/lib/glance" ];
      };

      services.glance = {
        enable = true;
        settings = {
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
                          title = "Linkding";
                          url = "https://bookmarks.\${BASE_DOMAIN}";
                          icon = "si:linkding";
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
    };
}
