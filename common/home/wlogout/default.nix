{ config, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
          label = "lock";
          action = "swaylock";
          text = "Lock";
          keybind = "l";
      }
      {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "Logout";
          keybind = "e";
      }
      {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
      }
      {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
      }
    ];
    style = ''
      * {
              background-image: none;
      }

      window {
              background-color: rgba(17, 17, 27, 0.85);
      }

      button {
          color: #b4befe;
              background-color: #313244;
              outline-style: none;
              border: none;
              border-width: 0px;
              background-repeat: no-repeat;
              background-position: center;
              background-size: 10%;
              border-radius: 0px;
              box-shadow: none;
              text-shadow: none;
          animation: gradient_f 20s ease-in infinite;
      }

      button:focus#lock {
              background-color: #44475a;
              background-size: 25%;
              margin-right : 30px;
              margin-bottom : 30px;
              border-radius: 20px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:focus#logout {
              background-color: #44475a;
              background-size: 25%;
              margin-right : 30px;
              margin-top : 30px;
              border-radius: 20px;
          animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:focus#shutdown {
              background-color: #44475a;
              background-size: 25%;
              margin-left : 20px;
              margin-bottom : 30px;
              border-radius: 20px;
              animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:focus#reboot {
              background-color: #44475a;
              background-size: 25%;
              margin-left : 30px;
              margin-top : 30px;
              border-radius: 20px;
              animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      #lock {
          background-image: image(url("./icons/lock.png"));
              border-top-left-radius: 50px;
      }

      #logout {
          background-image: image(url("./icons/logout.png"));
              border-bottom-left-radius: 50px;
      }

      #shutdown {
          background-image: image(url("./icons/shutdown.png"));
              border-top-right-radius: 50px;
      }

      #reboot {
          background-image: image(url("./icons/reboot.png"));
              border-bottom-right-radius: 50px;
      }    
    '';
  };

  home.file."${config.xdg.configHome}/wlogout/icons".source = ./icons;
}
