-- init.lua

HYPER = { "alt" }
HYPER_SHIFT = { table.unpack(HYPER), "shift" }

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
		resp = hs.execute("eject-auto", true)
		print(resp)
	end
)

-- Bluetooth ------------------------------------------------------------------

blueutil         = "/opt/homebrew/bin/blueutil"
blueutil_off     = blueutil .. " -p 0; "
blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect 2c-41-a1-88-27-9a"
hs.hotkey.bindSpec({ HYPER_SHIFT, "b" }, function () hs.execute(blueutil_off)     end)
hs.hotkey.bindSpec({ HYPER,       "b" }, function () hs.execute(blueutil_connect) end)

-- Wifi -----------------------------------------------------------------------

wifi_interface = "en0"
known_networks = {
	["Utopie"]          = "1997aaaaaa", -- Phone
	["EDIMAX"]          = "1997aaaaaa", -- NYC #41A
	["cos"]             = "0906802822", -- Room 645
	["RickyWramLin_5G"] = "room656656", -- Room 656
}

hs.hotkey.bindSpec({ HYPER_SHIFT, "w" }, function () hs.wifi.setPower(false, wifi_interface) end)
hs.hotkey.bindSpec({ HYPER,       "w" }, function () hs.wifi.setPower(true,  wifi_interface) end)

-- local wifi_menubar = hs.menubar.new():setTitle(hs.wifi.currentNetwork())
-- hs.hotkey.bindSpec(
-- 	{ HYPER, "w" },
-- 	function ()
-- 		hs.wifi.setPower(true, wifi_interface)
-- 		for network, password in pairs(known_networks) do
-- 			print("Trying to connect to network " .. network .. " ...")
-- 			if hs.wifi.associate(network, password, wifi_interface) then
-- 				print("Connected to network " .. network)
-- 				-- hs.menubar.new():setTitle(network)
-- 				return true
-- 			end
-- 		end
-- 		return false
-- 	end
-- )

-- Clipboard ------------------------------------------------------------------

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.menubar_title = "✂"
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.max_size = true
-- spoon.ClipboardTool.max_entry_size = 1000
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = { { "cmd", "shift" }, "v" } })
spoon.ClipboardTool:start()
