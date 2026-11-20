-- ~/.config/hypr/lua/variables.lua

local home = os.getenv("HOME")

return {
    home = home,
    scrPath = home .. "/.local/scripts",
    cachePath = home .. "/.cache/",
    mainMod = "SUPER",
    term = "ghostty",
    editor = "cursor",
    file = "dolphin",
    browser = "zen-browser",
}
