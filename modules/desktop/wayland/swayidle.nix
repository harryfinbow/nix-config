{
  flake.modules.homeManager.swayidle =
    { pkgs, ... }:
    {
      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = 600;
            command = "${pkgs.swaylock}/bin/swaylock --show-failed-attempts --daemonize";
          }
        ];
      };
    };
}
