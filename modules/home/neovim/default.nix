{ config, lib, ... }:

{
  options.modules.neovim = {
    enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      colorschemes.nord.enable = true;
      filetype.pattern = {
        ".*.bst" = "yaml";
      };

      opts = {
        number = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;

        foldenable = false;
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
      };

      plugins = {
        neo-tree.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        blink-cmp.enable = true;
        lualine.enable = true;
        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            pylsp.enable = true;
            terraformls.enable = true;
            yamlls.enable = true;
          };
        };
        web-devicons.enable = true;
      };

      clipboard.providers.wl-copy.enable = true;
    };
  };
}
