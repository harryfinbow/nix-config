{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    services.fail2ban = {
      enable = true;
      ignoreIP = [ "192.168.0.0/16" ];
    };
  };
}
