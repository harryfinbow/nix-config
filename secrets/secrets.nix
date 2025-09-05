let
  # Hosts
  alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha";
  bravo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo";
  delta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta";
  echo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP2Ho76RvxTQoScXNWCj8xywOfzhcfnzlAcZj0Eis/3+ harry@echo";
  foxtrot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITZ9CCMXyd2FZuAW6XgmRt6hQN7rLb8l1+0iexum/Rm harry@foxtrot";
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
}
