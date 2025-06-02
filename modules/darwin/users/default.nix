{ pkgs, ... }:

{
  users.users.harryf = {
    home = "/Users/harryf";
    shell = pkgs.fish;
  };

  system.primaryUser = "harryf";
}
