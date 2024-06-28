local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local naughty = require("naughty")

KeybindConfig = { }

function KeybindConfig:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self

    KEYVAR = "colemak"
    self:setKEYMAP()

    return o
end

function KeybindConfig:setMouse()
    root.buttons(gears.table.join(
        awful.button({ }, 3, function () MYMAINMENU:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    ))
end

function KeybindConfig:setKEYMAP()
    KEYMAP = { }

    KEYMAP.q = self:getKeymap("q", "q")
    KEYMAP.w = self:getKeymap("w", "w")
    KEYMAP.e = self:getKeymap("e", "f")
    KEYMAP.r = self:getKeymap("r", "p")
    KEYMAP.t = self:getKeymap("t", "g")
    KEYMAP.y = self:getKeymap("y", "j")
    KEYMAP.u = self:getKeymap("u", "l")
    KEYMAP.i = self:getKeymap("i", "u")
    KEYMAP.o = self:getKeymap("o", "y")
    KEYMAP.p = self:getKeymap("p", ";")
    KEYMAP.a = self:getKeymap("a", "a")
    KEYMAP.s = self:getKeymap("s", "r")
    KEYMAP.d = self:getKeymap("d", "s")
    KEYMAP.f = self:getKeymap("f", "t")
    KEYMAP.g = self:getKeymap("g", "d")
    KEYMAP.h = self:getKeymap("h", "h")
    KEYMAP.j = self:getKeymap("j", "n")
    KEYMAP.k = self:getKeymap("k", "e")
    KEYMAP.l = self:getKeymap("l", "i")
    KEYMAP.semi = self:getKeymap(";", "o")
    KEYMAP.z = self:getKeymap("z", "z")
    KEYMAP.x = self:getKeymap("x", "x")
    KEYMAP.c = self:getKeymap("c", "c")
    KEYMAP.v = self:getKeymap("v", "v")
    KEYMAP.b = self:getKeymap("b", "b")
    KEYMAP.n = self:getKeymap("n", "k")
    KEYMAP.m = self:getKeymap("m", "m")
end

function KeybindConfig:getKeymap(key1, key2)
    return key1
    --if KEYVAR ~= nil or KEYVAR == "qwerty" then
        --return key1
    --else
        --return key2
    --end
end

function KeybindConfig:setGlobalKeys()
    local globalKeys = gears.table.join(
        awful.key({ MODKEY,           }, KEYMAP.s,      hotkeys_popup.show_help,
            {description="show help", group="awesome"}),
        awful.key({ MODKEY,           }, KEYMAP.j,   awful.tag.viewprev,
            {description = "view previous", group = "tag"}),
        awful.key({ MODKEY,           }, KEYMAP.k,  awful.tag.viewnext,
            {description = "view next", group = "tag"}),
        awful.key({ MODKEY,           }, "Escape", awful.tag.history.restore,
            {description = "go back", group = "tag"}),

        awful.key({ MODKEY,           }, KEYMAP.h,
            function ()
                awful.client.focus.byidx( 1)
            end,
            {description = "focus next by index", group = "client"}
        ),
        awful.key({ MODKEY,           }, KEYMAP.l,
            function ()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),

        -- Layout manipulation
        awful.key({ MODKEY, "Shift"   }, KEYMAP.j, function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.k, function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.h, function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.l, function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),
        awful.key({ MODKEY,           }, KEYMAP.u, awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
        awful.key({ MODKEY,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            {description = "go back", group = "client"}),

        -- Standard program
        awful.key({ MODKEY,           }, "Return", function () awful.spawn(TERMINAL) end,
            {description = "open a terminal", group = "launcher"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.r, awesome.restart,
            {description = "reload awesome", group = "awesome"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.q, awesome.quit,
            {description = "quit awesome", group = "awesome"}),

        awful.key({ MODKEY,           }, ".",     function () awful.tag.incmwfact( 0.05)          end,
            {description = "increase master width factor", group = "layout"}),
        awful.key({ MODKEY,           }, ",",     function () awful.tag.incmwfact(-0.05)          end,
            {description = "decrease master width factor", group = "layout"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.h,     function () awful.tag.incnmaster( 1, nil, true) end,
            {description = "increase the number of master clients", group = "layout"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.l,     function () awful.tag.incnmaster(-1, nil, true) end,
            {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.h,     function () awful.tag.incncol( 1, nil, true)    end,
            {description = "increase the number of columns", group = "layout"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.l,     function () awful.tag.incncol(-1, nil, true)    end,
            {description = "decrease the number of columns", group = "layout"}),
        awful.key({ MODKEY,           }, "space", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
        awful.key({ MODKEY, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),

        awful.key({ MODKEY, "Control" }, KEYMAP.n,
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                end
            end,
            {description = "restore minimized", group = "client"}),

        -- Prompt
        awful.key({ MODKEY },            KEYMAP.r,     function ()
            awful.screen.focused().mywibox.cmd.visible = true
            awful.screen.focused().mypromptbox:run()
        end, {description = "run prompt", group = "launcher"}),

        awful.key({ MODKEY }, KEYMAP.x,
            function ()
                awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval",
                    done_callback = function(result)
                        naughty.notify(tostring(result))
                        awful.screen.focused().mywibox.cmd.visible = false
                    end
                }
            end,
            {description = "lua execute prompt", group = "awesome"}),
        -- Menubar
        awful.key({ MODKEY }, KEYMAP.p, function() menubar.show() end,
            {description = "show the menubar", group = "launcher"}),

        awful.key({ MODKEY, "Shift" }, KEYMAP.e, function() IS_MOUSE_LOCKED = not IS_MOUSE_LOCKED end),

        awful.key({ MODKEY }, KEYMAP.e, function()
            for s in screen do
                for key, val in pairs(s.mywibox) do
                    if key ~= "cmd" then
                        val.visible = not val.visible
                        val.input_passthrough = not val.input_passthrough
                    end
                end

                if false and s.mywibox.MB.visible then
                    s.mywibox.MB:struts({
                        top = 0,
                        left = 0,
                        bottom = (s.mywibox.MB.visible and s.mywibox.MB.height + beautiful.useless_gap or 0),
                        right = 0,
                    })
                end

                if s.mywibox.TL.visible then
                    s.mywibox.TL:struts({
                        top = (s.mywibox.TL.visible and s.mywibox.TL.height + beautiful.useless_gap or 0),
                        left = 0,
                        bottom = 0,
                        right = 0
                    })
                end
            end
        end, {
                description = "hide ui elements",
                group = "custom"
            })
    )

    for i = 1, 5 do
        globalKeys = gears.table.join(globalKeys,
            -- View tag only.
            awful.key({ MODKEY }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end,
                {description = "view tag #"..i, group = "tag"}),
            -- Toggle tag display.
            awful.key({ MODKEY, "Control" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                {description = "toggle tag #" .. i, group = "tag"}),
            -- Move client to tag.
            awful.key({ MODKEY, "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                {description = "move focused client to tag #"..i, group = "tag"}),
            -- Toggle tag on focused client.
            awful.key({ MODKEY, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                {description = "toggle focused client on tag #" .. i, group = "tag"})
        )
    end

    root.keys(globalKeys)
end

function KeybindConfig:createClientKeys()
    return gears.table.join(
        awful.key({ MODKEY,           }, KEYMAP.f,
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.c,      function (c) c:kill()                         end,
            {description = "close", group = "client"}),
        awful.key({ MODKEY, "Control" }, "space",  awful.client.floating.toggle                     ,
            {description = "toggle floating", group = "client"}),
        awful.key({ MODKEY, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
            {description = "move to master", group = "client"}),
        awful.key({ MODKEY,           }, KEYMAP.o,      function (c) c:move_to_screen()               end,
            {description = "move to screen", group = "client"}),
        awful.key({ MODKEY,           }, KEYMAP.t,      function (c) c.ontop = not c.ontop            end,
            {description = "toggle keep on top", group = "client"}),
        awful.key({ MODKEY,           }, KEYMAP.n,
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ MODKEY,           }, KEYMAP.m,
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ MODKEY, "Control" }, KEYMAP.m,
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ MODKEY, "Shift"   }, KEYMAP.m,
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"})
    )
end

function KeybindConfig:createClientButtons()
    return gears.table.join(
        awful.button({ }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
        awful.button({ MODKEY }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ MODKEY }, 3, function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )
end

return KeybindConfig:new(nil)
