-- init.lua

local HYPER = { "alt" }
local HYPER_SHIFT = { table.unpack(HYPER), "shift" }

-- Window Manager -------------------------------------------------------------

local wm = require("window-management")

hs.hotkey.bindSpec({ HYPER,       "down"  }, function() wm.move_to(wm.positions.bottom)     end)
hs.hotkey.bindSpec({ HYPER,       "left"  }, function() wm.move_to(wm.positions.left)       end)
hs.hotkey.bindSpec({ HYPER,       "right" }, function() wm.move_to(wm.positions.right)      end)
hs.hotkey.bindSpec({ HYPER,       "up"    }, function() wm.move_to(wm.positions.top)        end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "down"  }, function() wm.move_to(wm.positions.bottom_fat) end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "left"  }, function() wm.move_to(wm.positions.left_fat)   end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "right" }, function() wm.move_to(wm.positions.right_fat)  end)
hs.hotkey.bindSpec({ HYPER_SHIFT, "up"    }, function() wm.move_to(wm.positions.full)       end)

-- Applications and Shortcuts -------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "a" }, function () hs.application.open("Alacritty")  end)
hs.hotkey.bindSpec({ HYPER, "d" }, function () hs.application.open("Dictionary") end)
hs.hotkey.bindSpec({ HYPER, "f" }, function () hs.application.open("Finder")     end)
hs.hotkey.bindSpec({ HYPER, "l" }, function () hs.application.open("Line")       end)
hs.hotkey.bindSpec({ HYPER, "p" }, function () hs.application.open("Preview")    end)
hs.hotkey.bindSpec({ HYPER, "s" }, function () hs.application.open("Skim")       end)
hs.hotkey.bindSpec({ HYPER, "x" }, function () hs.application.open("Firefox")    end)
hs.hotkey.bindSpec({ HYPER, "e" },
	function ()
		local resp = hs.execute("eject-auto", true)
		print(resp)
	end
)

-- Bluetooth ------------------------------------------------------------------

local blueutil         = "/opt/homebrew/bin/blueutil"
local blueutil_off     = blueutil .. " -p 0; "
local blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect 2c-41-a1-88-27-9a"
hs.hotkey.bindSpec({ HYPER_SHIFT, "b" }, function () hs.execute(blueutil_off)     end)
hs.hotkey.bindSpec({ HYPER,       "b" }, function () hs.execute(blueutil_connect) end)

-- Wifi -----------------------------------------------------------------------

local wifi_interface = "en0"
local known_networks = {
	["Utopie"]          = "1997aaaaaa", -- Phone
	["sheep"]           = "1997aaaaaa", -- iPhone
	["EDIMAX"]          = "1997aaaaaa", -- NYC #41A
	["cos"]             = "0906802822", -- Room 645
	["RickyWramLin_5G"] = "room656656", -- Room 656
}

hs.hotkey.bindSpec({ HYPER_SHIFT, "w" }, function () hs.wifi.setPower(false, wifi_interface) end)
hs.hotkey.bindSpec({ HYPER,       "w" }, function () hs.wifi.setPower(true,  wifi_interface) end)

-- Wifi Menu Bar ---

WifiMenu = hs.menubar.new()
WifiMenu:autosaveName("WifiMenu")
WifiMenu:setClickCallback(function()
	local wifi_settings = "x-apple.systempreferences:com.apple.wifi-settings-extension"
	local command = "open " .. wifi_settings
	hs.execute(command)
end)

local wifi_set_display_name = function()
	local wifi_name = hs.wifi.currentNetwork(wifi_interface)
	if wifi_name then
		local max_display_length = 13
		if string.len(wifi_name) > max_display_length then
			wifi_name = string.sub(wifi_name, 1, max_display_length)
			wifi_name = string.gsub(wifi_name, "...$", "...")
		end
		WifiMenu:setTitle(wifi_name)
	else
		WifiMenu:setTitle("¯\\_(ツ)_/¯")
	end
end

wifi_set_display_name()
WifiWatcher = hs.wifi.watcher.new(wifi_set_display_name):start()

-- Keep = hs.menubar.new()
-- Keep:autosaveName("Keep"):setTitle("毋忘")
-- Keep:setClickCallback(function()
-- 	local browser = "firefox"
-- 	local website = "https://keep.google.com"
-- 	hs.execute("open -a " .. browser .. " " .. website)
-- end)

-- Clipboard ------------------------------------------------------------------

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.menubar_title = "✂"
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.max_size = false
-- spoon.ClipboardTool.max_entry_size = 1000
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = { { "cmd", "shift" }, "v" } })
spoon.ClipboardTool:start()

-------------------------------------------------------------------------------

hs.alert("Hammerspoon Config Loaded.")
