-- ~/.config/hypr/lua/autostart.lua

return function(ctx)
-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- Bluetooth systray
    hl.exec_cmd("blueman-applet &")
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
end)
end
