topLevel:
let
  stylixModule =
    { config, pkgs, ... }:
    {
      stylix = {
        enable = true;

        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

        fonts = {
          monospace = {
            package = pkgs.maple-mono.Normal-NF;
            name = "Maple Mono Normal NF";
          };

          sansSerif = {
            package = pkgs.inter;
            name = "Inter";
          };

          serif = config.stylix.fonts.sansSerif;

          sizes = {
            terminal = 14;
          };
        };

        image = ./wallpapers/snowy.png;
      };
    };
in
{
  flake.modules.nixos.default =
    { pkgs, ... }:
    {
      imports = [
        topLevel.inputs.stylix.nixosModules.stylix
        stylixModule
      ];

      stylix.cursor = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
      };

    };

  flake.modules.darwin.default = {
    imports = [
      topLevel.inputs.stylix.darwinModules.stylix
      stylixModule
    ];
  };

  flake.modules.homeManager.default = {
    # Failing due to not being able to download old Git archive (2 months old)
    stylix.targets.gnome.enable = false;
  };
}
