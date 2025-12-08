-- init.lua

local HYPER = { "alt" }
local HYPER_SHIFT = { table.unpack(HYPER), "shift" }

-- Clean Keyboard -------------------------------------------------------------

local clean_keyboard = require "clean-keyboard"
hs.hotkey.bindSpec({ HYPER_SHIFT, "k" }, clean_keyboard.lock_keyboard)

-- Applications and Shortcuts -------------------------------------------------

local am = require "app-manager"

hs.hotkey.bindSpec({ HYPER, "a" }, function() am.lauch_focus_or_rotate("iterm")      end)
hs.hotkey.bindSpec({ HYPER, "d" }, function() am.lauch_focus_or_rotate("Dictionary") end)
hs.hotkey.bindSpec({ HYPER, "f" }, function() am.lauch_focus_or_rotate("Finder")     end)
hs.hotkey.bindSpec({ HYPER, "x" }, function() am.lauch_focus_or_rotate("Firefox")    end)
hs.hotkey.bindSpec({ HYPER, "s" }, function() am.lauch_focus_or_rotate("Skim")       end)
hs.hotkey.bindSpec({ HYPER, "z" }, function() am.lauch_focus_or_rotate("Zotero")     end)

-- Window Manager -------------------------------------------------------------

local wm = require "window-manager"

hs.hotkey.bindSpec({ HYPER,       "down"  }, function() wm.move_to("bottom")          end)
hs.hotkey.bindSpec({ HYPER,       "left"  }, function() wm.move_to("left")            end)
hs.hotkey.bindSpec({ HYPER,       "right" }, function() wm.move_to("right")           end)
hs.hotkey.bindSpec({ HYPER,       "up"    }, function() wm.move_to("top")             end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "down"  }, function() wm.center()                   end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "left"  }, function() wm.adjust_width("left",  1/8) end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "right" }, function() wm.adjust_width("right", 1/8) end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "up"    }, function() wm.full()                     end)

-- Bluetooth ------------------------------------------------------------------

local blueutil         = "/opt/homebrew/bin/blueutil"
local blueutil_off     = blueutil .. " -p 0; "
local blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect 2c-41-a1-88-27-9a"
hs.hotkey.bindSpec({ HYPER,       "b" }, function() hs.execute(blueutil_connect) end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "b" }, function() hs.execute(blueutil_off)     end)

-- Wifi -----------------------------------------------------------------------

local wifi = require "wifi-menubar"

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
