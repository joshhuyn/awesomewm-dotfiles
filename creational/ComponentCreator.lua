local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

ComponentCreator = { }

function ComponentCreator:new(o)
    o = { }
    setmetatable(o, self)
    self.__index = self

    return o
end

function ComponentCreator:createAwesomeMenu()
    return {
       { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
       { "manual", TERMINAL .. " -e man awesome" },
       { "edit config", EDITOR_CMD .. " " .. awesome.conffile },
       { "restart", awesome.restart },
       { "quit", function() awesome.quit() end },
    }
end

function ComponentCreator:createMainMenu()
    return awful.menu({
        items = {
            {
                "awesome",
                myawesomemenu,
                beautiful.awesome_icon
            },
            {
                "open terminal",
                TERMINAL
            }
        }
    })

end

function ComponentCreator:createLauncher()
    return awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = MYMAINMENU
    })
end

function ComponentCreator:createTaglistButtons()
    return gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ MODKEY }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ MODKEY }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
end

function ComponentCreator:createTasklistButtons()
    return gears.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    {
                        raise = true
                    }
                )
            end
        end),
        awful.button({ }, 3, function()
            awful.menu.client_list({ theme = { width = 250 } })
        end),
        awful.button({ }, 4, function ()
            awful.client.focus.byidx(1)
        end),
        awful.button({ }, 5, function ()
            awful.client.focus.byidx(-1)
        end))
end

return ComponentCreator:new(nil)
