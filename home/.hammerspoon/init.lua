-- init.lua

local hyper = require "hyper"
hyper.install "F18"

-- Clean Keyboard -------------------------------------------------------------

local clean_keyboard = require "clean-keyboard"
hyper.bindShiftKey("k", clean_keyboard.lock_keyboard)

-- Applications and Shortcuts -------------------------------------------------

local am = require "app-manager"

hyper.bindKey("a", function() am.lauch_focus_or_rotate("ghostty")    end)
hyper.bindKey("d", function() am.lauch_focus_or_rotate("Dictionary") end)
hyper.bindKey("f", function() am.lauch_focus_or_rotate("Finder")     end)
hyper.bindKey("l", function() am.lauch_focus_or_rotate("Line")       end)
hyper.bindKey("s", function() am.lauch_focus_or_rotate("Skim")       end)
hyper.bindKey("x", function() am.lauch_focus_or_rotate("Firefox")    end)
hyper.bindKey("z", function() am.lauch_focus_or_rotate("Zotero")     end)

-- Window Manager -------------------------------------------------------------

local wm = require "window-manager"

hyper.bindKey("down",   function() wm.move_to("bottom") end)
hyper.bindKey("left",   function() wm.move_to("left")   end)
hyper.bindKey("right",  function() wm.move_to("right")  end)
hyper.bindKey("up",     function() wm.move_to("top")    end)
hyper.bindKey("return", function() wm.full()            end)
hyper.bindKey("space",  function() wm.center()          end)

hyper.bindShiftKey("left",  function() wm.adjust_width("left") end)
hyper.bindShiftKey("right", function() wm.adjust_width("right") end)

-- Bluetooth ------------------------------------------------------------------

local blueutil         = "/opt/homebrew/bin/blueutil"
local blueutil_off     = blueutil .. " -p 0; "
local blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect 2c-41-a1-88-27-9a"
hyper.bindKey("b",      function() hs.execute(blueutil_connect) end)
hyper.bindShiftKey("b", function() hs.execute(blueutil_off)     end)

-- Wifi -----------------------------------------------------------------------

local wifi = require "wifi-menubar"

hyper.bindKey("w",      function() hs.wifi.setPower(true,  wifi.interface) end)
hyper.bindShiftKey("w", function() hs.wifi.setPower(false, wifi.interface) end)

-- Clipboard ------------------------------------------------------------------

hs.loadSpoon "ClipboardTool"
local clipboard_toggle = { "cmd", "shift" }
spoon.ClipboardTool.menubar_title = "✂"
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.max_size = false
spoon.ClipboardTool.hist_size = 1000
-- spoon.ClipboardTool.max_entry_size = 10000
spoon.ClipboardTool:bindHotkeys { toggle_clipboard = { clipboard_toggle, "v" } }
spoon.ClipboardTool:start()

-- Caffeine -------------------------------------------------------------------

hs.loadSpoon "Caffeine"
hyper.bindKey("c", spoon.Caffeine.clicked)
-- spoon.Caffeine:bindHotkeys { toggle = { HYPER, "c" } }
spoon.Caffeine:start()

-- Reload Config --------------------------------------------------------------

hs.notify.new({
	title = "Hammerspoon",
	subtitle = "Config Loaded",
	informativeText = "Hammerspoon config loaded",
}):send()
