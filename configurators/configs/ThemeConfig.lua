local awful = require("awful")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")

ThemeConfig = { }

function ThemeConfig:new(o)
    o = {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function ThemeConfig:setupTheme()
    local theme = {}

    theme.dir = os.getenv("HOME") .. "/.config/awesome"
    theme.wallpaper = theme.dir .. "/resources/space.png"
    theme.font = "Hack 12"
    theme.fg_normal = "#DDDDFF"
    theme.fg_focus = "#EA6F81"
    theme.fg_urgent = "#CC9393"
    theme.bg_normal = "#1A1A1A"
    theme.bg_focus = "#313131"
    theme.bg_urgent = "#1A1A1A"
    theme.border_width = dpi(1)
    theme.border_normal = "#0"
    theme.border_focus = "#3F3F3F"
    theme.border_marked = "#0"
    theme.tasklist_bg_focus = "#1A1A1A"
    theme.titlebar_bg_focus = theme.bg_focus
    theme.titlebar_bg_normal = theme.bg_normal
    theme.titlebar_fg_focus = theme.fg_focus
    theme.menu_height = dpi(16)
    theme.menu_width = dpi(140)
    theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
    theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
    theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
    theme.layout_tile = theme.dir .. "/icons/tile.png"
    theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
    theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
    theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
    theme.layout_fairv = theme.dir .. "/icons/fairv.png"
    theme.layout_fairh = theme.dir .. "/icons/fairh.png"
    theme.layout_spiral = theme.dir .. "/icons/spiral.png"
    theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
    theme.layout_max = theme.dir .. "/icons/max.png"
    theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
    theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
    theme.layout_floating = theme.dir .. "/icons/floating.png"
    theme.widget_ac = theme.dir .. "/icons/ac.png"
    theme.widget_battery = theme.dir .. "/icons/battery.png"
    theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
    theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
    theme.widget_mem = theme.dir .. "/icons/mem.png"
    theme.widget_cpu = theme.dir .. "/icons/cpu.png"
    theme.widget_temp = theme.dir .. "/icons/temp.png"
    theme.widget_net = theme.dir .. "/icons/net.png"
    theme.widget_hdd = theme.dir .. "/icons/hdd.png"
    theme.widget_music = theme.dir .. "/icons/note.png"
    theme.widget_music_on = theme.dir .. "/icons/note_on.png"
    theme.widget_vol = theme.dir .. "/icons/vol.png"
    theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
    theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
    theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
    theme.widget_mail = theme.dir .. "/icons/mail.png"
    theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
    theme.tasklist_plain_task_name = true
    theme.tasklist_disable_icon = true
    theme.useless_gap = dpi(0)
    theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
    theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
    theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
    theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
    theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
    theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
    theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
    theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
    theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
    theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
    theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
    theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
    theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
    theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
    theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
    theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
    theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
    theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

    beautiful.init(theme)
end

function ThemeConfig:setupLayout()
    awful.layout.layouts = {
        awful.layout.suit.floating,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw,
    }
end

function ThemeConfig:createHud(s, tasklist, taglist, mylauncher)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            wibox.widget.textclock(),
            s.mylayoutbox,
        },
    }
end

function ThemeConfig:setupTitlebar()
    -- Add a titlebar if titlebars_enabled is set to true in the rules.
    client.connect_signal("request::titlebars", function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
            end)
        )

        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end)
end

function ThemeConfig:setWallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

return ThemeConfig:new(nil)
