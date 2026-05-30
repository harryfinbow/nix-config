topLevel: {
  flake.modules.homeManager.beansprout =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
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
        systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
        systemctl --user start beansprout-session.target

        exec ${pkgs.lib.getExe topLevel.inputs.beansprout.packages.${system}.default}
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
