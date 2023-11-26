{ config, pkgs, lib, ... }:
let
  liveCfgs = import ./livecfgs.nix; 
  vodCfgs = import ./vodcfgs.nix;

  createLiveScraper = cfg: {
    systemd.user.services."twitch-live-scraper-${cfg.channelName}" = {
      Unit = {
        Description = "Twitch live scraper for ${cfg.channelName}";
      };
      Service = {
        ExecStart = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/timer-scripts/twitch-live-scraper " +
        "-c ${cfg.channelName} " +
        "-o ${cfg.outputFolder} ";
        KillSignal = "SIGINT"; # yt-dlp only seems to handle SIGINT properly, SIGTERM leaves an incomplete file
      };
    };
  };

  createVodScraper = {channelName, outputFolder, onCalendar}: {
    systemd.user.services."twitch-vod-scraper-${channelName}" = {
      Unit = {
        Description = "Twitch vod scraper for ${channelName}";
      };
      Service = {
        ExecStart = "${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/timer-scripts/twitch-vod-scraper " +
        "-c ${channelName} " +
        "-o ${outputFolder} ";
        KillSignal = "SIGINT"; # yt-dlp only seems to handle SIGINT properly, SIGTERM leaves an incomplete file
      };
    };
    systemd.user.timers."twitch-vod-scraper-${channelName}" = {
      Unit = {
        Description = "Timer for the ${channelName} vod scraper";
      };
      Timer = {
        OnCalendar = onCalendar;
      };
    };
  };
in {
  imports = (map createLiveScraper liveCfgs) ++ (map createVodScraper vodCfgs);
}
