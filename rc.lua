pcall(require, "luarocks.loader")

os.execute("~/.config/awesome/prestartup.sh")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local configHandler = require("configurators/ConfigHandler"):setup()

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function (s) configHandler:setWallpaper(s) end)

client.connect_signal("manage", function (c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c)
    c.shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, false, false)
    end
    c.border_color = beautiful.border_focus
    c.border_width = beautiful.border_width
end)
client.connect_signal("unfocus", function(c)
    c.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height)
    end
    c.border_color = beautiful.border_normal
    c.border_width = beautiful.border_width
end)
