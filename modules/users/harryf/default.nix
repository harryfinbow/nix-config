topLevel:
let
  username = "harryf";
in
{
  flake.modules.darwin.${username} =
    { config, ... }:
    {
      system.primaryUser = username;

      users = {
        users.${username} = {
          home = "/Users/${username}";
          uid = 503; # Should match `dscl . -read /Users/<username> UniqueID`
        };

        # https://github.com/nix-darwin/nix-darwin/issues/811#issuecomment-2227415650
        knownUsers = [ username ];
      };
    };

  flake.modules.homeManager.${username} = {
    home = {
      username = "${username}";
      homeDirectory = "/Users/${username}";
    };
  };
}
