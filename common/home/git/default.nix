{ ... }: 

{
  programs.git = {
    enable = true;
    userName = "nervousfish";
    userEmail = "dev@nervous.fish";
    lfs.enable = true;
  };
}
