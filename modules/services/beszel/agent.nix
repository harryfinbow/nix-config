topLevel: {
  flake.modules.nixos."beszel/agent" =
    {
      config,
      lib,
      options,
      pkgs,
      ...
    }:
    {
      age.secrets."beszel-agent".file = (topLevel.self + "/secrets/beszel-agent.age");

      # Allows access of journal logs
      systemd.services.beszel-agent.serviceConfig.SupplementaryGroups = [ "systemd-journal" ];

      services.beszel.agent = {
        enable = true;
        openFirewall = true;
        environmentFile = config.age.secrets."beszel-agent".path;
      };
    };
}
