let
  hefty = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@hefty";
  dense = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@dense";
in
{
  # https://byamarmuric.gumroad.com/l/beautiful-topo-wallpaper-pack
  "wallpaper.age".publicKeys = [ hefty ];
  "work.git.age".publicKeys = [ dense ];
}
