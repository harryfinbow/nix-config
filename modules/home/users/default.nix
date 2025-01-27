{ currentSystem, currentSystemUser, config, lib, ... }:

let
  homeDirPrefix = if lib.hasSuffix "darwin" currentSystem then "Users" else "home";
in
{
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  home = {
    username = "${currentSystemUser}";
    homeDirectory = "/${homeDirPrefix}/${currentSystemUser}";
  };
}
