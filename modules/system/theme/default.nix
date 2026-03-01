topLevel: {
  flake.modules.nixos.default =
    { config, pkgs, ... }:
    {
      imports = [ topLevel.inputs.stylix.nixosModules.stylix ];

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

        cursor = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
          size = 16;
        };
      };
    };
}
