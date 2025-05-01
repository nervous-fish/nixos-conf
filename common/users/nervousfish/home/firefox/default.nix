{ lib, ... }:
{
  programs.firefox = {
    enable = true;
    # policies = {
    #   DisableProfileCustomizations = true;
    # };
    # profiles.nervousfish = {
    #   # extraConfig = builtins.readFile "${package}/user.js";
    #   # containersForce = true;
    #   userChrome = lib.mkBefore (builtins.readFile ./userChrome.css);
    # };
  };
}
