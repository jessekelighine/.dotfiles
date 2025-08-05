-- init.lua

local HYPER = { "alt" }
local HYPER_SHIFT = { table.unpack(HYPER), "shift" }

-- Window Manager -------------------------------------------------------------

local wm = require "window-management"

hs.hotkey.bindSpec({ HYPER,       "down"  }, function() wm.move_to("bottom") end)
hs.hotkey.bindSpec({ HYPER,       "left"  }, function() wm.move_to("left")   end)
hs.hotkey.bindSpec({ HYPER,       "right" }, function() wm.move_to("right")  end)
hs.hotkey.bindSpec({ HYPER,       "up"    }, function() wm.move_to("top")    end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "up"    }, function() wm.move_to("full")   end)

-- Applications and Shortcuts -------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "a" }, function() hs.application.open("Alacritty")  end)
hs.hotkey.bindSpec({ HYPER, "d" }, function() hs.application.open("Dictionary") end)
hs.hotkey.bindSpec({ HYPER, "f" }, function() hs.application.open("Finder")     end)
hs.hotkey.bindSpec({ HYPER, "x" }, function() hs.application.open("Firefox")    end)
hs.hotkey.bindSpec({ HYPER, "s" }, function() hs.application.open("Skim")       end)
-- hs.hotkey.bindSpec({ HYPER, "l" }, function() hs.application.open("Line")       end)
-- hs.hotkey.bindSpec({ HYPER, "p" }, function() hs.application.open("Preview")    end)
-- hs.hotkey.bindSpec({ HYPER, "e" }, function ()
-- 	local resp = hs.execute("eject-auto", true)
-- 	print(resp)
-- end)

-- Bluetooth ------------------------------------------------------------------

local blueutil         = "/opt/homebrew/bin/blueutil"
local blueutil_off     = blueutil .. " -p 0; "
local blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect 2c-41-a1-88-27-9a"
hs.hotkey.bindSpec({ HYPER,       "b" }, function() hs.execute(blueutil_connect) end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "b" }, function() hs.execute(blueutil_off)     end)

-- Wifi -----------------------------------------------------------------------

local wifi = require "wifi-menubar"
local known_networks = {
	["Utopie"]          = "1997aaaaaa", -- Phone
	["sheep"]           = "1997aaaaaa", -- iPhone
	["EDIMAX"]          = "1997aaaaaa", -- NYC #41A
	["cos"]             = "0906802822", -- Room 645
	["RickyWramLin_5G"] = "room656656", -- Room 656
}

hs.hotkey.bindSpec({ HYPER_SHIFT, "w" }, function() hs.wifi.setPower(false, wifi.interface) end)
hs.hotkey.bindSpec({ HYPER,       "w" }, function() hs.wifi.setPower(true,  wifi.interface) end)

-- Clipboard ------------------------------------------------------------------

hs.loadSpoon "ClipboardTool"
local clipboard_toggle = { "cmd", "shift" }
spoon.ClipboardTool.menubar_title = "✂"
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.max_size = false
-- spoon.ClipboardTool.max_entry_size = 10000
spoon.ClipboardTool:bindHotkeys { toggle_clipboard = { clipboard_toggle, "v" } }
spoon.ClipboardTool:start()

-- Caffeine -------------------------------------------------------------------

hs.loadSpoon "Caffeine"
spoon.Caffeine:bindHotkeys { toggle = { HYPER, "c" } }
spoon.Caffeine:start()

-- Reload Config --------------------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "r" }, function() hs.reload() end)

hs.notify.new({
	title = "Hammerspoon",
	subtitle = "Config Loaded",
	informativeText = "Hammerspoon config loaded",
}):send()
