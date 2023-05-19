{ ... }:

{
  programs.zsh = { 
    enable = true;
    localVariables = { 
      EDITOR="vim"; 
      TERM="xterm-256color"; 
    }; 
  };
}
