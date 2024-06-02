local awful = require("awful")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

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
    theme.resDir = theme.dir .. "/resources"
    theme.wallpaper = theme.resDir .. "/space.png"
    theme.font = "Hack 12"
    theme.fg_normal = "#DDDDFF"
    theme.fg_focus = "#EA6F81"
    theme.fg_urgent = "#CC9393"
    theme.bg_normal = "#1A1A1A"
    theme.bg_focus = "#313131"
    theme.bg_urgent = "#1A1A1A"
    theme.border_width = dpi(4)
    theme.border_normal = "#00000000"
    theme.border_focus = "#189BCC"
    theme.border_marked = "#0"
    theme.tasklist_bg_focus = "#1A1A1A"
    theme.titlebar_bg_focus = theme.bg_focus
    theme.titlebar_bg_normal = theme.bg_normal
    theme.titlebar_fg_focus = theme.fg_focus
    theme.menu_height = dpi(16)
    theme.menu_width = dpi(140)
    theme.menu_submenu_icon = theme.resDir .. "/icons/submenu.png"
    theme.taglist_squares_sel = theme.resDir .. "/icons/square_sel.png"
    theme.taglist_squares_unsel = theme.resDir .. "/icons/square_unsel.png"
    theme.layout_tile = theme.resDir .. "/icons/tile.png"
    theme.layout_tileleft = theme.resDir .. "/icons/tileleft.png"
    theme.layout_tilebottom = theme.resDir .. "/icons/tilebottom.png"
    theme.layout_tiletop = theme.resDir .. "/icons/tiletop.png"
    theme.layout_fairv = theme.resDir .. "/icons/fairv.png"
    theme.layout_fairh = theme.resDir .. "/icons/fairh.png"
    theme.layout_spiral = theme.resDir .. "/icons/spiral.png"
    theme.layout_dwindle = theme.resDir .. "/icons/dwindle.png"
    theme.layout_max = theme.resDir .. "/icons/max.png"
    theme.layout_fullscreen = theme.resDir .. "/icons/fullscreen.png"
    theme.layout_magnifier = theme.resDir .. "/icons/magnifier.png"
    theme.layout_floating = theme.resDir .. "/icons/floating.png"
    theme.widget_ac = theme.resDir .. "/icons/ac.png"
    theme.widget_battery = theme.resDir .. "/icons/battery.png"
    theme.widget_battery_low = theme.resDir .. "/icons/battery_low.png"
    theme.widget_battery_empty = theme.resDir .. "/icons/battery_empty.png"
    theme.widget_mem = theme.resDir .. "/icons/mem.png"
    theme.widget_cpu = theme.resDir .. "/icons/cpu.png"
    theme.widget_temp = theme.resDir .. "/icons/temp.png"
    theme.widget_net = theme.resDir .. "/icons/net.png"
    theme.widget_hdd = theme.resDir .. "/icons/hdd.png"
    theme.widget_music = theme.resDir .. "/icons/note.png"
    theme.widget_music_on = theme.resDir .. "/icons/note_on.png"
    theme.widget_vol = theme.resDir .. "/icons/vol.png"
    theme.widget_vol_low = theme.resDir .. "/icons/vol_low.png"
    theme.widget_vol_no = theme.resDir .. "/icons/vol_no.png"
    theme.widget_vol_mute = theme.resDir .. "/icons/vol_mute.png"
    theme.widget_mail = theme.resDir .. "/icons/mail.png"
    theme.widget_mail_on = theme.resDir .. "/icons/mail_on.png"
    theme.tasklist_plain_task_name = true
    theme.tasklist_disable_icon = false
    theme.useless_gap = dpi(2)
    theme.titlebar_close_button_focus = theme.resDir .. "/icons/titlebar/close_focus.png"
    theme.titlebar_close_button_normal = theme.resDir .. "/icons/titlebar/close_normal.png"
    theme.titlebar_ontop_button_focus_active = theme.resDir .. "/icons/titlebar/ontop_focus_active.png"
    theme.titlebar_ontop_button_normal_active = theme.resDir .. "/icons/titlebar/ontop_normal_active.png"
    theme.titlebar_ontop_button_focus_inactive = theme.resDir .. "/icons/titlebar/ontop_focus_inactive.png"
    theme.titlebar_ontop_button_normal_inactive = theme.resDir .. "/icons/titlebar/ontop_normal_inactive.png"
    theme.titlebar_sticky_button_focus_active = theme.resDir .. "/icons/titlebar/sticky_focus_active.png"
    theme.titlebar_sticky_button_normal_active = theme.resDir .. "/icons/titlebar/sticky_normal_active.png"
    theme.titlebar_sticky_button_focus_inactive = theme.resDir .. "/icons/titlebar/sticky_focus_inactive.png"
    theme.titlebar_sticky_button_normal_inactive = theme.resDir .. "/icons/titlebar/sticky_normal_inactive.png"
    theme.titlebar_floating_button_focus_active = theme.resDir .. "/icons/titlebar/floating_focus_active.png"
    theme.titlebar_floating_button_normal_active = theme.resDir .. "/icons/titlebar/floating_normal_active.png"
    theme.titlebar_floating_button_focus_inactive = theme.resDir .. "/icons/titlebar/floating_focus_inactive.png"
    theme.titlebar_floating_button_normal_inactive = theme.resDir .. "/icons/titlebar/floating_normal_inactive.png"
    theme.titlebar_maximized_button_focus_active = theme.resDir .. "/icons/titlebar/maximized_focus_active.png"
    theme.titlebar_maximized_button_normal_active = theme.resDir .. "/icons/titlebar/maximized_normal_active.png"
    theme.titlebar_maximized_button_focus_inactive = theme.resDir .. "/icons/titlebar/maximized_focus_inactive.png"
    theme.titlebar_maximized_button_normal_inactive = theme.resDir .. "/icons/titlebar/maximized_normal_inactive.png"

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

function ThemeConfig:createPrompt()
    for s in screen do
        s.mypromptbox = awful.widget.prompt {
            prompt = "Run: ",
            done_callback = function(result)
                naughty.notify(tostring(result))
                awful.screen.focused().mywibox.cmd.visible = false
            end
        }
    end
end

function ThemeConfig:createHud(s, tasklist_buttons, taglist_buttons)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing_widget = {
                {
                    forced_width = 5,
                    forced_height = 24,
                    thickness = 1,
                    color = "#777777",
                    widget = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 1,
                id = "background_role",
                widget = wibox.container.background,
            },
            {
                {
                    id = "clienticon",
                    widget = awful.widget.clienticon,
                },
                margins = 5,
                widget = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects)
                self:get_children_by_id("clienticon")[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        }
    }

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )

    local wiboxHeight = beautiful.get_font_height(nil) * 1.5
    local gap = beautiful.useless_gap

    local topRight = wibox({ width = dpi(300), height = wiboxHeight })

    topRight:setup({
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                awful.widget.keyboardlayout(),
                wibox.widget.systray(),
                -- battery TODO 
            },
            wibox.widget.textclock(),
            {
                layout = wibox.layout.fixed.horizontal,
                s.mylayoutbox,
            }
        },
        widget = wibox.container.margin
    })

    topRight.x = s.geometry.x + s.geometry.width - topRight.width - gap
    topRight.y = s.geometry.y + gap

    local middleBottom = wibox({
        width = s.geometry.width / 2,
        height = wiboxHeight * 2,
        shape = function(cr, width, height)
            gears.shape.rounded_bar(cr, width, height)
        end
    })

    middleBottom:setup {
        layout = wibox.layout.align.horizontal,
        s.mytasklist
    }

    middleBottom.x = s.geometry.x + s.geometry.width / 2 - middleBottom.width / 2
    middleBottom.y = s.geometry.y + s.geometry.height - middleBottom.height - gap

    local topLeft = wibox({ width = dpi(100), height = wiboxHeight })

    topLeft:setup({
        {
            layout = wibox.layout.align.horizontal,
            s.mytaglist
        },
        top = 4,
        bottom = 4,
        widget = wibox.container.margin
    })

    topLeft.x = s.geometry.x + gap
    topLeft.y = s.geometry.y + gap

    local commandPrompt = wibox({ width = dpi(300), height = wiboxHeight })

    commandPrompt:setup({
        {
            layout = wibox.layout.align.horizontal,
            s.mypromptbox
        },
        top = 4,
        bottom = 4,
        widget = wibox.container.margin,
    })

    commandPrompt.x = s.geometry.x + s.geometry.width / 2 - commandPrompt.width / 2
    commandPrompt.y = s.geometry.y + s.geometry.height / 2


    s.mywibox = {
        TL = topLeft,
        TR = topRight,
        MB = middleBottom,
        cmd = commandPrompt
    }

    for _, val in pairs(s.mywibox) do
        val.screen = s

        val.ontop = true
        val.visible = true
        val.input_passthrough = false

        if val.shape == nil then
            val.shape = gears.shape.rounded_bar
        end
    end

    commandPrompt.visible = false
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
