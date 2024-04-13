{ pkgs, ... }:

{
  users.users = {
    harry = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
