-- init.lua

local hyper = require "hyper"

hyper.install "F18"

-- Sleepy ---------------------------------------------------------------------

local sleepy = require "sleepy"

hyper.bindKey("c", sleepy.toggleDisplay)
hyper.bindShiftKey("s", sleepy.toggleSystem)
sleepy.enableMenubar()

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

-- Wifi -----------------------------------------------------------------------

local wifi = require "wifi-menubar"

hyper.bindKey("w",      function() hs.wifi.setPower(true,  wifi.interface) end)
hyper.bindShiftKey("w", function() hs.wifi.setPower(false, wifi.interface) end)

-- Bluetooth ------------------------------------------------------------------

local blueutil         = "/opt/homebrew/bin/blueutil"
local blueutil_off     = blueutil .. " -p 0;"
local blueutil_connect = blueutil .. " -p 1;"

hyper.bindKey("b",      function() hs.execute(blueutil_connect) end)
hyper.bindShiftKey("b", function() hs.execute(blueutil_off)     end)

-- Clipboard ------------------------------------------------------------------

hs.loadSpoon "ClipboardTool"
local clipboard_toggle = { "cmd", "shift" }
spoon.ClipboardTool.menubar_title = "✂"
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.max_size = false
spoon.ClipboardTool.hist_size = 1000

-- Do no store images
-- do
-- 	local origStore = spoon.ClipboardTool.pasteboardToClipboard
-- 	function spoon.ClipboardTool:pasteboardToClipboard(item_type, item)
-- 		if item_type == "image" then return end
-- 		return origStore(self, item_type, item)
-- 	end
-- end

spoon.ClipboardTool:bindHotkeys { toggle_clipboard = { clipboard_toggle, "v" } }
spoon.ClipboardTool:start()

-- Remove images from clipboard history
hs.hotkey.bind({ "cmd", "alt", "shift" }, "v", function()
	local ct = spoon.ClipboardTool
	local clipboard_key = "ClipboardTool.items"
	-- Pause the clipboard watcher so nothing is added mid-cleanup
	if ct.timer then ct.timer:stop() end
	if ct.selectorobj then ct.selectorobj:hide() end
	-- Look through the clipboard history and remove any images
	local kept, removed = {}, 0
	for _, entry in ipairs(hs.settings.get(clipboard_key) or {}) do
		if entry.type == "image" then
			removed = removed + 1
		else
			table.insert(kept, entry)
		end
	end
	-- Update the clipboard history and restart the watcher
	hs.settings.set(clipboard_key, kept)
	ct:start()
	local images = removed == 1 and "image" or "images"
	local message = ("📋 Removed %d " .. images .. " from Clipboard"):format(removed)
	hs.alert.show(message, 0.5)
end)

-- Reload Config --------------------------------------------------------------

hs.notify.new({
	title = "Hammerspoon",
	subtitle = "Config Loaded",
	informativeText = "Hammerspoon config loaded",
}):send()
