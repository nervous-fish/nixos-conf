{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=DP-3, 2560x1440@120, 0x0, 1 
    monitor=DP-1, 2560x1440@120, 2560x0, 1
    monitor=HDMI-A-1, 2560x1440@120, 5120x0, 1

    workspace=name:term, monitor:DP-3, default:true
    workspace=name:main, monitor:DP-1, default:true
    workspace=name:web, monitor:HDMI-A-1, default:true
    workspace=name:social, monitor:HDMI-A-1

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    exec-once = hyprpaper & waybar & avizo-service

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # Some default env vars.
    env = XCURSOR_SIZE,24

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

        numlock_by_default = true
    }

    source = ./common.conf

    windowrulev2 = workspace name:web, class:^(firefox)
    windowrulev2 = workspace name:term, class:^(Alacritty)
    windowrulev2 = workspace name:social, class:^(discord)

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, name:term
    bind = $mainMod, 2, workspace, name:main
    bind = $mainMod, 3, workspace, name:web
    bind = $mainMod, 4, workspace, name:social
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, name:term
    bind = $mainMod SHIFT, 2, movetoworkspace, name:main
    bind = $mainMod SHIFT, 3, movetoworkspace, name:web
    bind = $mainMod SHIFT, 4, movetoworkspace, name:social
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10
    
    bind = $mainMod, tab, swapactiveworkspaces, current r
    bind = $mainMod SHIFT, tab, swapactiveworkspaces, current l
    '';
}
