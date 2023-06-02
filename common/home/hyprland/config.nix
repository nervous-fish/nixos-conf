{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=,preferred,auto,auto

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    exec-once = hyprpaper & waybar & avizo-service

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # Some default env vars.
    env = XCURSOR_SIZE,24

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = fr
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

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 20
        border_size = 2

        # dracula
        col.active_border = rgb(44475a) rgb(bd93f9) 90deg
        col.inactive_border = rgba(44475aaa)
        col.group_border = rgba(282a36dd)
        col.group_border_active = rgb(bd93f9) rgb(44475a) 90deg
        # non-gradient alternative
        #col.active_border = rgb(bd93f9)
        #col.inactive_border = rgba(44475aaa)
        #col.group_border = rgba(282a36dd)
        #col.group_border_active = rgb(bd93f9)
        # darker alternative
        #col.active_border = rgb(44475a) # or rgb(6272a4)
        #col.inactive_border = rgb(282a36)
        #col.group_border = rgb(282a36)
        #col.group_border_active = rgb(44475a) # or rgb(6272a4)v
        
        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 10
        blur = true
        blur_size = 8
        blur_passes = 5
        blur_new_optimizations = true
        multisample_edges = true
        
        # dracula   
        col.shadow = rgba(1E202966)
        # suggested shadow setting
        drop_shadow = yes
        shadow_range = 60
        shadow_offset = 1 2
        shadow_render_power = 3
        shadow_scale = 0.97
    }

    animations {
      enabled = yes
      bezier = wind, 0.05, 0.9, 0.1, 1.05
      bezier = winIn, 0.1, 1.1, 0.1, 1.1
      bezier = winOut, 0.3, -0.3, 0, 1
      bezier = liner, 1, 1, 1, 1
      animation = windows, 1, 6, wind, slide
      animation = windowsIn, 1, 6, winIn, slide
      animation = windowsOut, 1, 5, winOut, slide
      animation = windowsMove, 1, 5, wind, slide
      animation = border, 1, 1, liner
      animation = borderangle, 1, 30, liner, loop
      animation = fade, 1, 10, default
      animation = workspaces, 1, 5, wind   
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true
    }

    misc {
        disable_hyprland_logo = true
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    windowrulev2 = bordercolor rgb(ff5555),xwayland:1 # check if window is xwayland
    
    windowrulev2 = opacity 0.90 0.90,class:^(Alacritty)$
    
    windowrulev2 = float,class:^(firefox)$,title:^(Library)$
    windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$
    windowrulev2 = float,class:^(pavucontrol)$
    windowrulev2 = float,class:^(org.gnome.Nautilus)$
    windowrulev2 = float,title:^(Open)

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, Q, killactive,
    bind = $mainMod, delete, exit,
    bind = $mainMod, W, togglefloating,
    bind = ALT, return, fullscreen,

    bind = $mainMod, E, exec, nautilus
    bind = $mainMod, return, exec, alacritty
    bind = $mainMod, F, exec, firefox
    bind = $mainMod, backspace, exec, pidof wlogout || wlogout -b 2 -c 0 -r 0 -L 555 -R 555  -T 300 -B 300 --protocol layer-shell
    bind = $mainMod, L, exec, swaylock
    bindr = SUPER, SUPER_L, exec, pkill rofi || rofi -show drun
    #bind = $mainMod, tab, exec, rofi -show window
    
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    
    bind = $mainMod, code:107, exec, grim -g "$(slurp)" - | swappy -f - # screenshot snip
    bind = $mainMod_ALT, code:107, exec, grim ~/Pictures/$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png') # print current screen

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, ampersand, workspace, 1
    bind = $mainMod, eacute, workspace, 2
    bind = $mainMod, quotedbl, workspace, 3
    bind = $mainMod, apostrophe, workspace, 4
    bind = $mainMod, parenleft, workspace, 5
    bind = $mainMod, minus, workspace, 6
    bind = $mainMod, egrave, workspace, 7
    bind = $mainMod, underscore, workspace, 8
    bind = $mainMod, ccedilla, workspace, 9
    bind = $mainMod, agrave, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, ampersand, movetoworkspace, 1
    bind = $mainMod SHIFT, eacute, movetoworkspace, 2
    bind = $mainMod SHIFT, quotedbl, movetoworkspace, 3
    bind = $mainMod SHIFT, apostrophe, movetoworkspace, 4
    bind = $mainMod SHIFT, parenleft, movetoworkspace, 5
    bind = $mainMod SHIFT, minus, movetoworkspace, 6
    bind = $mainMod SHIFT, egrave, movetoworkspace, 7
    bind = $mainMod SHIFT, underscore, movetoworkspace, 8
    bind = $mainMod SHIFT, ccedilla, movetoworkspace, 9
    bind = $mainMod SHIFT, agrave, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1
 
    bind = , XF86AudioRaiseVolume, exec, volumectl -u up
    bind = , XF86AudioLowerVolume, exec, volumectl -u down
    bind = , XF86AudioMute, exec, volumectl toggle-mute
    bind = , XF86MonBrightnessUp, exec, lightctl up
    bind = , XF86MonBrightnessDown, exec, lightctl down

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow 
  '';
}
