{ pkgs, ... }:

{
  imports = [
    ./default.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
      font.size = 16;
    };
  };

  programs.git = {
    enable = true;

    extraConfig.url."git@personal.github.com:harryfinbow".insteadOf = "git@github.com:harryfinbow";

    includes = [
      {
        contents = {
          user = {
            email = "harry@finbow.dev";
          };
        };

        condition = "hasconfig:remote.*.url:git@github.com:harryfinbow/*";
      }
    ];
  };
}
