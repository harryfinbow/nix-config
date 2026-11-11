{
  flake.modules.nixos.ssh =
    { lib, ... }:
    {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = lib.mkForce "no";
        };
      };

      services.fail2ban = {
        enable = true;
        ignoreIP = [ "192.168.0.0/16" ];
      };
    };
}
