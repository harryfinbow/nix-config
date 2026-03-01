topLevel:
let
  username = "harryf";
in
{
  flake.modules.darwin.${username} = {
    users.users.${username}.home = "/Users/${username}";
    system.primaryUser = username;
  };

  flake.modules.homeManager.${username} = {
    home = {
      username = "${username}";
      homeDirectory = "/Users/${username}";
    };
  };
}
