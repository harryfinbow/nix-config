let
  alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha";
  bravo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo";
  delta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyVl7Sg9XYn6CCMdTOd+KJcuOLeW+vcU5Dpk5TbIuvF harry@delta";
  echo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILr+DZFexXxh3F4ioXrz/EX0hOqmH5t2etjldm8rEkfm harry@echo";
in
{
  # https://byamarmuric.gumroad.com/l/beautiful-topo-wallpaper-pack
  "wallpaper.age".publicKeys = [ alpha bravo echo ];
  "work.git.age".publicKeys = [ alpha bravo echo ];
}
