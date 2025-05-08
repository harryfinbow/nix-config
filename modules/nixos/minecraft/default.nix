{ config, currentSystemUser, lib, inputs, pkgs, ... }:

{
  imports = [ inputs.minix.nixosModules.default ];

  options.modules.minecraft = {
    enable = lib.mkEnableOption "enables minecraft servers";
  };

  config = lib.mkIf config.modules.minecraft.enable {
    environment.systemPackages = with pkgs; [ jdk17 ];

    services.minix = {
      eula = true;
      user = currentSystemUser;

      # State stored in `/var/lib/minix/<instance_name>`
      instances = {
        cisco = {
          enable = true;
          jvmMaxAllocation = "10G";
          jvmInitialAllocation = "2G";

          # This doesn't seem to work?
          jvmPackage = pkgs.jdk17;

          serverConfig = {
            server-port = 25565;
            motd = "Welcome to Cisco's Fantasy Medieval RPG!";
            
            allow-flight = true;
            difficulty = 3; # Hard
            max-players = 4;
            view-distance = 12;
            white-list = true;
          };
        };
      };
    };
  };
}

