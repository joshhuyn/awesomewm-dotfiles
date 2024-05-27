local menubar = require("menubar")

ConfigHandler = {
    errorConfig = nil,
    themeConfig = nil,
    keybindConfig = nil,
}

function ConfigHandler:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self
    self.errorConfig = require("configurators/configs/ErrorConfig")
    self.themeConfig = require("configurators/configs/ThemeConfig")
    self.keybindConfig = require("configurators/configs/KeybindConfig")

    return o
end

function ConfigHandler:setGlobals(componentFactory)
    TERMINAL = "alacritty"
    menubar.utils.terminal = TERMINAL
    EDITOR = os.getenv("EDITOR") or "vim"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
    MODKEY = "Mod4"
    MYMAINMENU = componentFactory.createMainMenu()
    MYAWESOMEMENU = componentFactory.createAwesomeMenu()
end

function ConfigHandler:setupErrors()
    self.errorConfig:setup()
end

function ConfigHandler:setupTheme()
    self.themeConfig:setupTheme()
    self.themeConfig:setupLayout()
end

function ConfigHandler:createHud(s, tasklist, taglist, myLauncher)
    self.themeConfig:createHud(s, tasklist, taglist, myLauncher)
end

function ConfigHandler:setMouse()
    self.keybindConfig:setMouse()
end

function ConfigHandler:setGlobalKeys()
    self.keybindConfig:setGlobalKeys()
end

function ConfigHandler:createClientKeys()
    return self.keybindConfig:createClientKeys()
end

function ConfigHandler:createClientButtons()
    return self.keybindConfig:createClientButtons()
end

function ConfigHandler:setupTitlebar()
    self.themeConfig:setupTitlebar()
end

function ConfigHandler:setWallpaper(s)
    self.themeConfig:setWallpaper(s)
end

return ConfigHandler:new(nil)
