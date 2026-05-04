hl.env('GDK_BACKEND',         'wayland,x11')
hl.env('QT_QPA_PLATFORM',     'wayland;xcb')
hl.env('SDL_VIDEODRIVER',     'wayland')
hl.env('CLUTTER_BACKEND',     'wayland')
hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')
hl.env('XDG_SESSION_TYPE',    'wayland')
hl.env('XDG_SESSION_DESKTOP', 'Hyprland')
hl.env('GDK_SCALE',           '1')
hl.env('GTK_THEME',           'rose-pine-moon')
hl.env('XCURSOR_THEME',       'Bibata-Modern-Classic')
hl.env('XCURSOR_SIZE',        '22')
hl.env('QT_WAYLAND_DISABLE_WINDOWDECORATION', '1')

hl.on('hyprland.start', function ()
    hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-size 22')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme rose-pine-moon')
    hl.exec_cmd('hyprctl setcursor Bibata-Modern-Classic 22')
    hl.exec_cmd('hyprpm reload')
    hl.exec_cmd('~/.scripts/start_xdp.sh')
    hl.exec_cmd('~/.scripts/random_wallpaper.sh')
    hl.exec_cmd('~/.scripts/toggle_lockscreen_timeout.sh')
    hl.exec_cmd('dunst')
    hl.exec_cmd('eww daemon')
    hl.exec_cmd('eww open bar')
    hl.exec_cmd('rm -rf ~/.cache/cliphist/db')
    hl.exec_cmd('wl-paste --watch cliphist store')
    hl.exec_cmd('qalc -exrates')
    hl.exec_cmd('lxsession')
    hl.exec_cmd('mpd')
    hl.exec_cmd('~/.scripts/startup.sh')
end)

local dim = function(hex, power)
    hex = string.lower(hex)
    local rgb = { tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16) }
    return string.format('%02x', math.floor(rgb[1] * (1 - power))) ..
           string.format('%02x', math.floor(rgb[2] * (1 - power))) ..
           string.format('%02x', math.floor(rgb[3] * (1 - power)))
end

hl.config({
    general = {
        border_size = 2,

        gaps_in  = 8,
        gaps_out = 25,

        col = {
            active_border   = 'rgb(1d1b2c)',
            inactive_border = string.format('rgb(%s)', dim('1d1b2c', 0.3)),
        },

        layout = 'master',

        no_focus_fallback     = false,
        resize_on_border      = false,
        allow_tearing         = false,
        resize_corner         = 0,
        modal_parent_blocking = true,

        snap = { enabled = false },
    },

    decoration = {
        rounding       = 12,
        rounding_power = 4.0,

        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,

        dim_modal    = true,
        dim_inactive = true,
        dim_strength = 0.3,
        dim_special  = 0.3,
        dim_around   = 0.3,

        border_part_of_window = true,

        blur = {
            enabled = true,

            size   = 8,
            passes = 3,

            ignore_opacity    = true,
            new_optimizations = true,
            xray              = false,

            special       = true,
            popups        = false,
            input_methods = false,
        },

        shadow = { enabled = false },
        glow   = { enabled = false },
    },

    animations = {
        enabled = true,
        workspace_wraparound = false,
    },

    input = {
        kb_model   = '',
        kb_layout  = 'us,ara',
        kb_variant = 'dvorak,',
        kb_options = '',
        kb_rules   = '',
        kb_file    = '',

        numlock_by_default = false,
        resolve_binds_by_sym = false,

        repeat_rate  = 30,
        repeat_delay = 350,

        sensitivity   = 0.0,
        accel_profile = '',
        rotation      = 0,
        left_handed   = false,

        scroll_points      = '',
        scroll_method      = '',
        scroll_button      = 0,
        scroll_button_lock = false,
        scroll_factor      = 1.0,
        natural_scroll     = false,

        follow_mouse           = 1,
        follow_mouse_shrink    = 0,
        follow_mouse_threshold = 0.0,

        focus_on_close              = 0,
        mouse_refocus               = true,
        float_switch_override_focus = 1,

        special_fallthrough     = false,
        off_window_axis_events  = 1,
        emulate_discrete_scroll = 1,

        touchpad = {
            disable_while_typing    = false,
            natural_scroll          = false,
            scroll_factor           = 1.0,
            middle_button_emulation = true,
            tap_to_click            = true,
            drag_lock               = 0,
            tap_and_drag            = true,
            flip_x                  = false,
            flip_y                  = false,
            drag_3fg                = 0,
        },

        touchdevice = { enabled = false },
    },

    misc = {
        disable_hyprland_logo          = true,
        disable_splash_rendering       = true,
        disable_scale_notification     = false,
        font_family                    = 'CaskaydiaMono Nerd Font',
        force_default_wallpaper        = 0,
        vrr                            = 0,
        mouse_move_enables_dpms        = true,
        key_press_enables_dpms         = true,
        always_follow_on_dnd           = true,
        layers_hog_keyboard_focus      = true,
        animate_manual_resizes         = false,
        animate_mouse_windowdragging   = false,
        disable_autoreload             = false,
        enable_swallow                 = false,
        focus_on_activate              = false,
        mouse_move_focuses_monitor     = true,
        session_lock_xray              = false,
        close_special_on_empty         = true,
        on_focus_under_fullscreen      = 2,
        exit_window_retains_fullscreen = false,
        middle_click_paste             = true,
        enable_anr_dialog              = false,
    },

    layout = {
        single_window_aspect_ratio = { 0, 0 },
    },

    binds = {
        pass_mouse_when_bound            = false,
        scroll_event_delay               = 0,
        workspace_back_and_forth         = false,
        hide_special_on_workspace_change = true,
        focus_preferred_method           = 0,
        movefocus_cycles_fullscreen      = false,
        disable_keybind_grabbing         = false,
        drag_threshold                   = 0,
    },

    render = {
        cm_auto_hdr = 0,
    },

    cursor = {
        invisible                       = false,
        hotspot_padding                 = 0,
        inactive_timeout                = 1.5,
        no_warps                        = true,
        warp_on_change_workspace        = 0,
        warp_on_toggle_special          = 0,
        default_monitor                 = 'DP-2',
        zoom_factor                     = 1.0,
        zoom_rigid                      = false,
        zoom_detached_camera            = true,
        hide_on_key_press               = true,
        warp_back_after_non_mouse_input = false,
        zoom_disable_aa                 = true,
    },

    ecosystem = {
        no_update_news      = false,
        no_donation_nag     = true,
        enforce_permissions = false,
    },

    quirks = {
        prefer_hdr = 0,
    },

    debug = {
        vfr                  = true,
        suppress_errors      = false,
        disable_scale_checks = false,
        error_limit          = 20,
        error_position       = 0,
        invalidate_fp16      = 1,
    },

    master = {
        allow_small_split    = false,
        special_scale_factor = 0.8,
        mfact                = 0.66,
        new_status           = 'master',
        new_on_top           = true,
        new_on_active        = 'none',
        orientation          = 'left',
        smart_resizing       = true,
        drop_at_cursor       = true,
        always_keep_position = false,
    },
})

hl.curve('easeOutQuart', { type = 'bezier', points = { { 0.19, 0.91 }, { 0.37, 1.0 } } })

hl.animation({ leaf = 'windowsIn',        enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'popin 0%'  })
hl.animation({ leaf = 'windowsOut',       enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'popin 60%' })
hl.animation({ leaf = 'windowsMove',      enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'popin 60%' })
hl.animation({ leaf = 'windows',          enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })

hl.animation({ leaf = 'layers',           enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'popin 70%' })

hl.animation({ leaf = 'fadeIn',           enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fadeOut',          enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fadeSwitch',       enabled = false, speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fadeShadow',       enabled = false, speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fadeDim',          enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fadeLayers',       enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'fade',             enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })

hl.animation({ leaf = 'border',           enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })
hl.animation({ leaf = 'borderangle',      enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })

hl.animation({ leaf = 'specialWorkspace', enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'slidevert' })
hl.animation({ leaf = 'workspaces',       enabled = true,  speed = 5, bezier = 'easeOutQuart', style = 'slide'     })

hl.animation({ leaf = 'zoomFactor',       enabled = true,  speed = 5, bezier = 'easeOutQuart'                      })

hl.monitor({
    output = '',
    mode = 'preferred',
    position = 'auto',
    scale = 1
})

-- hl.monitor({
--     output = 'eDP-1',
--     mode = '1920x1080@59.93',
--     position = '0x0',
--     scale = 1
--     reserved_area = { top = 0, bottom = 225, left = 0, right = 0 },
-- })
hl.monitor({
    output = 'eDP-1',
    mode = '1280x720@59.93',
    position = '0x0',
    scale = 1,
    reserved_area = { top = 0, bottom = 225, left = 0, right = 0 },
})

hl.monitor({
    output = 'DP-2',
    mode = '3840x2160@60.00',
    position = '-3840x-1440',
    scale = 1,
    bitdepth = 10,
    cm = 'srgb'
})

hl.monitor({
    output = 'HDMI-A-1',
    mode = '2560x1440@59.95',
    position = '-6400x-720',
    scale = 1,
    bitdepth = 10,
    cm = 'srgb'
})

hl.workspace_rule({ workspace = '1', monitor = 'HDMI-A-1' })
hl.workspace_rule({ workspace = '2', monitor = 'DP-2'     })
hl.workspace_rule({ workspace = '3', monitor = 'DP-2'     })
hl.workspace_rule({ workspace = '4', monitor = 'HDMI-A-1' })
hl.workspace_rule({ workspace = '5', monitor = 'DP-2'     })
hl.workspace_rule({ workspace = '6', monitor = 'DP-2'     })
hl.workspace_rule({ workspace = '7', monitor = 'eDP-1'    })
hl.workspace_rule({ workspace = '8', monitor = 'HDMI-A-1' })
hl.workspace_rule({ workspace = '9', monitor = 'HDMI-A-1' })

hl.window_rule({ match = { float = true                               }, center       = true             })
hl.window_rule({ match = { class = '^brave-browser$'                  }, workspace    = '3 silent'       })
hl.window_rule({ match = { class = '^(mpv)|(freetube)$'               }, workspace    = '5 silent'       })
hl.window_rule({ match = { class = '^org.pwmt.zathura$'               }, workspace    = '6 silent'       })
hl.window_rule({ match = { class = '^virt-manager$'                   }, workspace    = '7 silent'       })
hl.window_rule({ match = { class = '^org.mozilla.Thunderbird$'        }, workspace    = '8 silent'       })
hl.window_rule({ match = { class = '^wezterm kabmat$'                 }, workspace    = 'special silent' })
hl.window_rule({ match = { class = '(gcr-prompter)|((pinentry-)(.*))' }, stay_focused = true             })
hl.window_rule({
    match = {
        class = '^(brave)|(xdg-desktop-portal-gtk)$',
        title = '^(.*wants to open)|(.*wants to save)|(Save File)|(All Files)$',
    },
    float = true,
    size = { '(monitor_w*0.6)', '(monitor_h*0.5)' },
})

hl.layer_rule({ match = { namespace = 'selection' }, no_anim = true })

hl.bind('SUPER + SHIFT + CTRL + q', hl.dsp.exit())

hl.bind('SUPER + k',         hl.dsp.layout('cycleprev loop'))
hl.bind('SUPER + j',         hl.dsp.layout('cyclenext loop'))
hl.bind('SUPER + SHIFT + k', hl.dsp.layout('swapprev loop'))
hl.bind('SUPER + SHIFT + j', hl.dsp.layout('swapnext loop'))
hl.bind('SUPER + d',         hl.dsp.layout('removemaster'))
hl.bind('SUPER + i',         hl.dsp.layout('addmaster'))
hl.bind('SUPER + return',    hl.dsp.layout('swapwithmaster master'))

hl.bind('SUPER + q',              hl.dsp.window.close())
hl.bind('SUPER + h',              hl.dsp.window.resize({ x = -25, y = 10, relative = true }))
hl.bind('SUPER + l',              hl.dsp.window.resize({ x =  25, y =  0, relative = true }))
hl.bind('SUPER + SHIFT + return', hl.dsp.window.float({ action = 'toggle' }))

hl.bind('SUPER + mouse:272', hl.dsp.window.drag(),   { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind('SUPER + f', hl.dsp.window.fullscreen({ mode = 'fullscreen', action = 'toggle' }))
hl.bind('SUPER + m', hl.dsp.window.fullscreen({ mode = 'maximized',  action = 'toggle' }))
hl.bind('SUPER + z', hl.dsp.exec_cmd('(eww active-windows | grep bar > /dev/null) && (eww close-all && hyprctl eval "hl.config({ general = { gaps_out = 100 } })") || (eww close-all && eww open bar && hyprctl eval "hl.config({ general = { gaps_out = 25 } })")'))

hl.bind('SUPER + u', hl.dsp.exec_cmd('swaylock -f -e -F -L -K -r --font "CaskaydiaMono Nerd Font" --bs-hl-color eb6f92 --separator-color 00000000 --key-hl-color 9ccfd8 --inside-color 1d1b2c --ring-color 3a4454 --text-color e0def4 --inside-clear-color 4f413d --ring-clear-color f6c177 --text-clear "Cleared" --text-clear-color e0def4 --inside-ver-color 25364a --ring-ver-color 3e8fb0 --text-ver "Verifying" --text-ver-color e0def4 --inside-wrong-color 4c2e43 --ring-wrong-color eb6f92 --text-wrong "Wrong" --text-wrong-color e0def4 -i ~/.config/hypr/lockscreen.png --effect-blur 10x4 --indicator --indicator-radius 90'))
hl.bind('SUPER + space', hl.dsp.exec_cmd('~/.scripts/keyboard_layout.sh'))

hl.bind('SUPER + mouse_up',   function() hl.config({ cursor = { zoom_factor = math.max(1.0, hl.get_config('cursor.zoom_factor') * 0.9) } }) end, { mouse = true })
hl.bind('SUPER + mouse_down', function() hl.config({ cursor = { zoom_factor = hl.get_config('cursor.zoom_factor') * 1.1                } }) end, { mouse = true })
hl.bind('SUPER + mouse:274',  function() hl.config({ cursor = { zoom_factor = 1.0                                                      } }) end, { mouse = true })

hl.bind('CTRL + 1',         hl.dsp.focus({ workspace = 1 }))
hl.bind('CTRL + 2',         hl.dsp.focus({ workspace = 2 }))
hl.bind('CTRL + 3',         hl.dsp.focus({ workspace = 3 }))
hl.bind('CTRL + 4',         hl.dsp.focus({ workspace = 4 }))
hl.bind('CTRL + 5',         hl.dsp.focus({ workspace = 5 }))
hl.bind('CTRL + 6',         hl.dsp.focus({ workspace = 6 }))
hl.bind('CTRL + 7',         hl.dsp.focus({ workspace = 7 }))
hl.bind('CTRL + 8',         hl.dsp.focus({ workspace = 8 }))
hl.bind('CTRL + 9',         hl.dsp.focus({ workspace = 9 }))

hl.bind('CTRL + SHIFT + 1', hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind('CTRL + SHIFT + 2', hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind('CTRL + SHIFT + 3', hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind('CTRL + SHIFT + 4', hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind('CTRL + SHIFT + 5', hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind('CTRL + SHIFT + 6', hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind('CTRL + SHIFT + 7', hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind('CTRL + SHIFT + 8', hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind('CTRL + SHIFT + 9', hl.dsp.window.move({ workspace = 9, follow = false }))

hl.bind('xf86audiomute',         hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'))
hl.bind('xf86audiomicmute',      hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'))
hl.bind('xf86audiolowervolume',  hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-'), { repeating = true })
hl.bind('xf86audioraisevolume',  hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+'), { repeating = true })
hl.bind('xf86monbrightnessdown', hl.dsp.exec_cmd('brightnessctl set 10%-'),                     { repeating = true })
hl.bind('xf86monbrightnessup',   hl.dsp.exec_cmd('brightnessctl set +10%'),                     { repeating = true })

hl.bind('SUPER + CTRL + minus',        hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'), { repeating = true })
hl.bind('SUPER + CTRL + equal',        hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'), { repeating = true })
hl.bind('SUPER + CTRL + 0',            hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'))
hl.bind('SUPER + CTRL + bracketright', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'))

hl.bind('SUPER + CTRL + b', hl.dsp.exec_cmd('~/.scripts/fans.sh toggle'))
hl.bind('SUPER + CTRL + r', hl.dsp.exec_cmd('~/.scripts/random_wallpaper.sh'))
hl.bind('SUPER + CTRL + n', hl.dsp.exec_cmd('eww close control_center'))
hl.bind('SUPER + CTRL + g', hl.dsp.exec_cmd('rm -rf ~/.cache/cliphist/db'))
hl.bind('SUPER + CTRL + u', hl.dsp.exec_cmd('~/.scripts/toggle_lockscreen_timeout.sh'))
hl.bind('SUPER + CTRL + f', hl.dsp.exec_cmd('~/.scripts/toggle_bar.sh'))

hl.bind('SUPER + SHIFT + a', hl.dsp.exec_cmd('rofi -show run'))
hl.bind('SUPER + SHIFT + e', hl.dsp.exec_cmd('~/.scripts/rofi/rofi_emoji/rofi_emoji.sh'))
hl.bind('SUPER + SHIFT + c', hl.dsp.exec_cmd('~/.scripts/rofi/rofi_calc.sh'))
hl.bind('SUPER + SHIFT + d', hl.dsp.exec_cmd('rofi_et'))
hl.bind('SUPER + SHIFT + g', hl.dsp.exec_cmd('cliphist list | rofi -i -dmenu -display-columns 2 -p "Clipboard" | cliphist decode | wl-copy'))

hl.bind('SUPER + ALT + return', hl.dsp.exec_cmd('wezterm'))
hl.bind('SUPER + ALT + b',      hl.dsp.exec_cmd('brave'))
hl.bind('SUPER + ALT + e',      hl.dsp.exec_cmd('wezterm start bash -c "sleep 0.2 && ranger"'))
hl.bind('SUPER + ALT + w',      hl.dsp.exec_cmd('wezterm start bash -c "sleep 0.2 && nmtui"'))
hl.bind('SUPER + ALT + f',      hl.dsp.exec_cmd('/opt/FreeTube/freetube --ozone-platform-hint=wayland --new-window'))
hl.bind('SUPER + ALT + n',      hl.dsp.exec_cmd('eww open control_center'))
hl.bind('SUPER + ALT + s',      hl.dsp.exec_cmd('REGION="$(slurp -o)" ; grim -g "$REGION" && notify-send -a "Grim" "Screenshot taken" "Region: $REGION"'))
hl.bind('SUPER + ALT + k', function()
    hl.dispatch(hl.dsp.exec_cmd('pgrep kabmat || wezterm start --class "wezterm kabmat" bash -c "sleep 0.2 && kabmat"'))
    hl.dispatch(hl.dsp.workspace.toggle_special())
end)

hl.config({
    plugin = {
        hyprbars = {
            enabled                    = true,
            bar_color                  = string.format('rgb(%s)', dim('1d1b2c', 0.3)),
            bar_height                 = 30,
            bar_padding                = 15,
            bar_blur                   = false,
            bar_precedence_over_border = false,
            bar_title_enabled          = true,
            bar_text_size              = 15,
            bar_text_font              = 'CaskaydiaMono Nerd Font',
            bar_text_align             = 'center',
            col                        = { text = string.format('rgb(%s)', dim('908caa', 0.3)) },
            on_double_click            = 'hyprctl dispatch \'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })\'',
        },
    },
})

hl.window_rule({
    match                    = { focus = true },
    ['hyprbars:bar_color']   = 'rgb(1d1b2c)',
    ['hyprbars:title_color'] = 'rgb(908caa)',
})
