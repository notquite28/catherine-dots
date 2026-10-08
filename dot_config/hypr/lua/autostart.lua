-- ~/.config/hypr/lua/autostart.lua

return function(ctx)
-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- Slow app launch fix
    hl.exec_cmd("systemctl --user import-environment &")
    hl.exec_cmd("hash dbus-update-activation-environment 2>/dev/null &")
    hl.exec_cmd("dbus-update-activation-environment --systemd &")
    -- Bluetooth systray
    hl.exec_cmd("blueman-applet &")
    -- Desktop portal
    hl.exec_cmd("xdg-desktop-portal-hyprland &")
    -- Launcher / clipboard server
    hl.exec_cmd("vicinae server")
    -- Dictation
    hl.exec_cmd([[sh -c "pgrep -x handy >/dev/null || handy --start-hidden" &]])
    -- Noctalia v5 owns the wallpaper and shell surfaces.
    hl.exec_cmd("noctalia")
    -- System services
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("nm-applet --indicator &")
    -- Clipboard history
    hl.exec_cmd([[bash -c "wl-paste --watch cliphist store &"]])
end)
end
