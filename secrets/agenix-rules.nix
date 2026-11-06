let
  # Hosts
  alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha";
  bravo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo";
  delta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta";
  echo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2Ho76RvxTQoScXNWCj8xywOfzhcfnzlAcZj0Eis/3+ harry@echo";
  foxtrot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G harry@foxtrot";

  node1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZN5x9Gde3Ck49NCf2ygHcJjRm7Zd4iyBkv7ahICCQi";

  minecraft = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWDTkG+H/jUtXcyn8sgzLfTyLBRdeiPsxyA2bAtLGze";
in
{
  "caddy.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "git.age" = {
    armor = true;
    publicKeys = [
      alpha
      bravo
      echo
    ];
  };

  "glance.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "linkding.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "password.age" = {
    armor = true;
    publicKeys = [
      alpha
      bravo
      delta
      echo
      foxtrot

      node1

      minecraft
    ];
  };

  "rathole-client.age" = {
    armor = true;
    publicKeys = [
      alpha
      minecraft
    ];
  };

  "rathole-server.age" = {
    armor = true;
    publicKeys = [
      alpha
      node1
    ];
  };

  "restic/linkding/credentials.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "restic/linkding/password.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "restic/linkding/repository.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "restic/minecraft/credentials.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "restic/minecraft/password.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "restic/minecraft/repository.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "transmission.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };

  "vpn.age" = {
    armor = true;
    publicKeys = [
      alpha
      delta
    ];
  };
}
