topLevel: {
  flake.modules.nixos.home-assistant =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    let
      excludedComponents = [
        "assist_pipeline"
        "conversation"
        "cloud"
      ];

      homeAssistant = config.services.home-assistant;
      pythonVersion = homeAssistant.package.python3Packages.python.pythonVersion;

      defaultComponents =
        (builtins.fromJSON (
          builtins.readFile "${homeAssistant.package}/lib/python${pythonVersion}/site-packages/homeassistant/components/default_config/manifest.json"
        )).dependencies;

      wantedComponents = builtins.filter (x: !(builtins.elem x excludedComponents)) defaultComponents;

      bambulab = pkgs.callPackage ./_bambulab.nix { };
    in
    {
      services.caddy.virtualHosts."home.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString config.services.home-assistant.config.http.server_port}
      '';

      environment = lib.optionalAttrs (options.environment ? persistence) {
        persistence."/persist/system".directories = [ config.services.home-assistant.configDir ];
      };

      services.home-assistant = {
        enable = true;

        customComponents = [ bambulab ];

        extraComponents = wantedComponents ++ [
          "isal" # https://www.home-assistant.io/integrations/isal
          "zha"

          # Not really sure why these are needed? I think it has discovered
          # some devices and then activates these (which error unless configured)
          "apple_tv"
          "samsungtv"
        ];

        config = {
          # https://www.home-assistant.io/integrations/default_config/
          default_config = { };

          automation = "!include automations.yaml";

          homeassistant = {
            time_zone = lib.mkForce null;
          };

          http = {
            trusted_proxies = [ "::1" ];
            use_x_forwarded_for = true;
          };
        };
      };
    };
}
