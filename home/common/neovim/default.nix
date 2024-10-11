{ inputs, ... }:

{

  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    plugins = {
      neo-tree.enable = true;
      telescope.enable = true;
    };
  };

}
