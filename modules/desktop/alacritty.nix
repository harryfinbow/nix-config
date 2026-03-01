{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      programs.alacritty = {
        enable = true;

        settings = {
          terminal.shell.program = "${pkgs.fish}/bin/fish";
          window = {
            decorations = "none";
            dynamic_padding = true;
            padding = {
              x = 5;
              y = 5;
            };
          };
        };
      };
    };
}
