{ pkgs, config, ... }:

{
  users.users."${config.users.name}".packages = with pkgs; [
    hello
  ];
}
