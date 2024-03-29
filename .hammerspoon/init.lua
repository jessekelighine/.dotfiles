-- init.lua

HYPER   = { "alt" }
HYPER_S = { "alt", "shift" }

-- Applications ---------------------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "a" }, function () hs.application.open("Alacritty")  end)
hs.hotkey.bindSpec({ HYPER, "d" }, function () hs.application.open("Dictionary") end)
hs.hotkey.bindSpec({ HYPER, "f" }, function () hs.application.open("Finder")     end)
hs.hotkey.bindSpec({ HYPER, "l" }, function () hs.application.open("Line")       end)
hs.hotkey.bindSpec({ HYPER, "p" }, function () hs.application.open("Preview")    end)
hs.hotkey.bindSpec({ HYPER, "s" }, function () hs.application.open("Skim")       end)
hs.hotkey.bindSpec({ HYPER, "x" }, function () hs.application.open("Firefox")    end)

-- Eject ----------------------------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "e" }, function ()
	resp = hs.execute("eject-auto", true)
	print(resp)
end)

-- Bluetooth ------------------------------------------------------------------

blueutil         = "/usr/local/bin/blueutil"
blueutil_off     = blueutil .. " -p 0; "
blueutil_connect = blueutil .. " -p 1; " .. blueutil .. " --connect Sicherung"
hs.hotkey.bindSpec({ HYPER_S, "b" }, function () hs.execute(blueutil_off)     end)
hs.hotkey.bindSpec({ HYPER,   "b" }, function () hs.execute(blueutil_connect) end)

-- Wifi -----------------------------------------------------------------------

wifi_interface = "en0"
known_networks = {
	["Utopie"]          = "1997aaaaaa",
	["cos"]             = "0906802822", -- Room 645
	["RickyWramLin_5G"] = "room656656", -- Room 656
}

hs.hotkey.bindSpec({ HYPER_S, "w" }, function () hs.wifi.setPower(false, wifi_interface) end)
hs.hotkey.bindSpec({ HYPER,   "w" }, function ()
	hs.wifi.setPower(true,  wifi_interface)
	local available_networks = hs.wifi.availableNetworks(wifi_interface)
	for network, password in pairs(known_networks) do
		print("Checking if", network, "is available...")
		for _, available_network in pairs(available_networks) do
			if ( network == available_network ) then
				print("Network", network, "is available, connecting...")
				hs.wifi.associate(network, password, wifi_interface)
				print("Network", network, "connected.")
				return
			end
		end
	end
end)

-- Clipboard ------------------------------------------------------------------

HYPER_CT = { "cmd", "shift" }
hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.menubar_title     = "✂"
spoon.ClipboardTool.paste_on_select   = true
spoon.ClipboardTool.show_in_menubar   = false
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = { HYPER_CT, "v" } })
spoon.ClipboardTool:start()
