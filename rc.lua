pcall(require, "luarocks.loader")


require("awful.autofocus")
require("awful.hotkeys_popup.keys")

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local configHandler = require("configurators/ConfigHandler"):setup()

--awful.screen.set_auto_dpi_enabled(true)
IS_MOUSE_LOCKED = false

function handle_mouse_lock(c)
        if IS_MOUSE_LOCKED then
            local margin = 0
            local cg = c:geometry()
            local mg = mouse.coords()

            local newx = mg.x

            if mg.x <= cg.x then
                newx = cg.x + margin
            elseif mg.x >= cg.x  + cg.width then
                newx = cg.x + cg.width - margin
            end

            local newy = mg.y

            if mg.y <= cg.y then
                newy = cg.y + margin
            elseif mg.y >= cg.y + cg.height then
                newy = cg.y + cg.height - margin
            end

            mouse.coords({ x = newx, y = newy })
        end
end

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

    c:connect_signal("mouse::leave", handle_mouse_lock)
end)

client.connect_signal("unfocus", function(c)
    c.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height)
    end
    c.border_color = beautiful.border_normal
    c.border_width = beautiful.border_width

    c:disconnect_signal("mouse::leave", handle_mouse_lock)
end)
