{ config, inputs, lib, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  options.modules.neovim = {
    enable = lib.mkEnableOption "enables neovim";
  };

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;
      clipboard.providers.wl-copy.enable = true;
      plugins = {
        neo-tree.enable = true;
        telescope.enable = true;
      };
    };
  };
}
