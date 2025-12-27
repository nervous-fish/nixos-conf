{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "nervousfish";
      user.email = "119760848+nervous-fish@users.noreply.github.com";
    };
    lfs.enable = true;
  };
}
