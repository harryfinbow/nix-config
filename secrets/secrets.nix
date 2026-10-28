let
  # Hosts
  alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha";
  bravo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo";
  delta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta";
  echo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2Ho76RvxTQoScXNWCj8xywOfzhcfnzlAcZj0Eis/3+ harry@echo";
  foxtrot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G harry@foxtrot";

  node1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZN5x9Gde3Ck49NCf2ygHcJjRm7Zd4iyBkv7ahICCQi";
in
{
  "caddy.age".publicKeys = [
    alpha
    delta
  ];

  "git.age".publicKeys = [
    alpha
    bravo
    echo
  ];

  "glance.age".publicKeys = [
    alpha
    delta
  ];

  "linkding.age".publicKeys = [
    alpha
    delta
  ];

  "password.age".publicKeys = [
    alpha
    bravo
    delta
    echo
    foxtrot

    node1
  ];

  "transmission.age".publicKeys = [
    alpha
    delta
  ];

  "vpn.age".publicKeys = [
    alpha
    delta
  ];
}
