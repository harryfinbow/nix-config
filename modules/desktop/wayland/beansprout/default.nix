topLevel: {
  flake.modules.homeManager.beansprout =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;

      variables = builtins.concatStringsSep " " [
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
        "NIXOS_OZONE_WL"
        "XCURSOR_THEME"
        "XCURSOR_SIZE"
      ];

      systemdActivation = ''
        ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd ${variables}
        systemctl --user stop beansprout-session.target
        systemctl --user start beansprout-session.target
      '';
    in
    {
      home.packages = [
        topLevel.inputs.beansprout.packages.${system}.default
        pkgs.river
        pkgs.wl-clipboard
      ];

      xdg.configFile."beansprout/config.kdl".source = ./config.kdl;

      xdg.configFile."river/init".source = pkgs.writeShellScript "init" ''
        ### This file was generated with Nix. Don't modify this file directly.

        ### SYSTEMD INTEGRATION ###
        ${systemdActivation}

        beansprout
      '';

      systemd.user.targets.beansprout-session = {
        Unit = {
          Description = "beansprout compositor session";
          Documentation = [ "man:systemd.special(7)" ];
          BindsTo = [ "graphical-session.target" ];
          Wants = [ "graphical-session-pre.target" ];
          After = [ "graphical-session-pre.target" ];
        };
      };
    };
}
