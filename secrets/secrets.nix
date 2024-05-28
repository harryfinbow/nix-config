let
  harry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@hefty";
in
{
  # https://byamarmuric.gumroad.com/l/beautiful-topo-wallpaper-pack
  "wallpaper.age".publicKeys = [ harry ];
}
