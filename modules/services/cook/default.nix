{
  flake.modules.nixos.cook =
    {
      pkgs,
      lib,
      ...
    }:
    let
      port = 9080;
      configDir = "/var/lib/recipes";
      recipeDir = "${configDir}/cook";
    in
    {
      services.caddy.virtualHosts."cook.{$BASE_DOMAIN}".extraConfig = ''
        reverse_proxy localhost:${toString port}
      '';

      systemd.services.cook = {
        description = "TODO";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${lib.getExe pkgs.cook-cli} server --port ${toString port} ${recipeDir}";
          Restart = "on-failure";
        };
      };
    };
}
