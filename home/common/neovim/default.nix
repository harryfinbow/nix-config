{ inputs, ... }:

{

  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      neo-tree.enable = true;
      telescope.enable = true;
    };
  };

}
