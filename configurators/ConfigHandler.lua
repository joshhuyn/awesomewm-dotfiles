local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

ConfigHandler = {
    errorConfig = nil,
    themeConfig = nil,
    keybindConfig = nil,
    componentFactory = nil,
}

function ConfigHandler:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self
    self.errorConfig = require("configurators/configs/ErrorConfig")
    self.themeConfig = require("configurators/configs/ThemeConfig")
    self.keybindConfig = require("configurators/configs/KeybindConfig")

    self.componentFactory = require("creational/ComponentCreator")

    return o
end

function ConfigHandler:setup()
    self:setGlobals()

    self.errorConfig:setup()

    self.themeConfig:setupTheme()
    self.themeConfig:setupLayout()
    self.themeConfig:createPrompt()

    self.themeConfig:setupTitlebar()

    self.keybindConfig:setGlobalKeys()

    self:setRules()
    self:addWibar()

    return self
end

function ConfigHandler:setGlobals()
    TERMINAL = "alacritty"
    menubar.utils.terminal = TERMINAL
    EDITOR = os.getenv("EDITOR") or "vim"
    EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
    MODKEY = "Mod4"
    MYMAINMENU = self.componentFactory.createMainMenu()
    MYAWESOMEMENU = self.componentFactory.createAwesomeMenu()
end

function ConfigHandler:setRules()
    awful.rules.rules = {
        {
            rule = { },
            properties = { border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = self:createClientKeys(),
                buttons = self:createClientButtons(),
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
            }
        },

        -- Floating clients.
        { 
            rule_any = {
                instance = {
                    "DTA",  -- Firefox addon DownThemAll.
                    "copyq",  -- Includes session name in class.
                    "pinentry",
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "MessageWin",  -- kalarm.
                    "Sxiv",
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer"},

                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester",  -- xev.
                },
                role = {
                    "AlarmWindow",  -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
                }
            }, properties = { floating = true }},

        -- Add titlebars to normal clients and dialogs
        { rule_any = {type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = false }
        },

        -- Set Firefox to always map on the tag named "2" on screen 1.
        -- { rule = { class = "Firefox" },
        --   properties = { screen = 1, tag = "2" } },
    }
    -- }}}
end

function ConfigHandler:addWibar()
    local taglist_buttons = self.componentFactory.createTaglistButtons()
    local tasklist_buttons = self.componentFactory.createTasklistButtons()

    awful.screen.connect_for_each_screen(function(s)
        awful.tag({ "1", "2", "3", "4", "5"}, s, awful.layout.layouts[2])

        self:setWallpaper(s)
        self.themeConfig:createHud(s, tasklist_buttons, taglist_buttons)
    end)
end

function ConfigHandler:setMouse()
    self.keybindConfig:setMouse()
end

function ConfigHandler:createClientKeys()
    return self.keybindConfig:createClientKeys()
end

function ConfigHandler:createClientButtons()
    return self.keybindConfig:createClientButtons()
end

function ConfigHandler:setWallpaper(s)
    self.themeConfig:setWallpaper(s)
end

return ConfigHandler:new(nil)
