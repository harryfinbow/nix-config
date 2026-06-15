{
  flake.modules.homeManager.swayidle =
    { pkgs, ... }:
    {
      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 600;
            command = "${pkgs.wlopm}/bin/wlopm --off DP-1";
            resumeCommand = "${pkgs.wlopm}/bin/wlopm --on DP-1";
          }
        ];
      };
    };
}
