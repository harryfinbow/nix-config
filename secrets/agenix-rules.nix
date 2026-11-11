let
  # Hosts
  eclipse = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+";
  nautilus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2Ho76RvxTQoScXNWCj8xywOfzhcfnzlAcZj0Eis/3+";
  nomad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G";
  polaris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc";

  # Servers
  node0 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF";
  node1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZN5x9Gde3Ck49NCf2ygHcJjRm7Zd4iyBkv7ahICCQi";

  # VMs
  minecraft = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWDTkG+H/jUtXcyn8sgzLfTyLBRdeiPsxyA2bAtLGze";
in
{
  "beszel-agent.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
      node1
    ];
  };

  "caddy.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "git.age" = {
    armor = true;
    publicKeys = [
      polaris
      eclipse
      nautilus
    ];
  };

  "glance.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "linkding.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "password.age" = {
    armor = true;
    publicKeys = [
      polaris
      eclipse
      node0
      nautilus
      nomad

      node1

      minecraft
    ];
  };

  "rathole/client.age" = {
    armor = true;
    publicKeys = [
      polaris
      minecraft
    ];
  };

  "rathole/server.age" = {
    armor = true;
    publicKeys = [
      polaris
      node1
    ];
  };

  "restic/linkding/credentials.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/linkding/password.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/linkding/repository.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/memos/credentials.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/memos/password.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/memos/repository.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/minecraft/credentials.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/minecraft/password.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "restic/minecraft/repository.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "tinyauth/beszel.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "tinyauth/config.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "tinyauth/linkding.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "tinyauth/memos.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "transmission.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };

  "vpn.age" = {
    armor = true;
    publicKeys = [
      polaris
      node0
    ];
  };
}
