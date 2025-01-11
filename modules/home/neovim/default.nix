{ config, inputs, lib, ... }:

{
  options.modules.neovim = {
    enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      plugins = {
        neo-tree.enable = true;
        telescope.enable = true;
      };

      clipboard.providers.wl-copy.enable = true;
    };
  };
}
