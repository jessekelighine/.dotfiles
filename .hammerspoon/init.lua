-- init.lua

HYPER       = { "alt" }
HYPER_SHIFT = { "alt", "shift" }

-- Applications ---------------------------------------------------------------

hs.hotkey.bindSpec({ HYPER, "a" }, function () hs.application.open("Alacritty")  end)
hs.hotkey.bindSpec({ HYPER, "d" }, function () hs.application.open("Dictionary") end)
hs.hotkey.bindSpec({ HYPER, "f" }, function () hs.application.open("Finder")     end)
hs.hotkey.bindSpec({ HYPER, "l" }, function () hs.application.open("Line")       end)
hs.hotkey.bindSpec({ HYPER, "p" }, function () hs.application.open("Preview")    end)
hs.hotkey.bindSpec({ HYPER, "s" }, function () hs.application.open("Skim")       end)
hs.hotkey.bindSpec({ HYPER, "x" }, function () hs.application.open("Firefox")    end)

-- Bluetooth ------------------------------------------------------------------

blueutil         = "/usr/local/bin/blueutil"
blueutil_off     = blueutil .. " -p 0;"
blueutil_connect = blueutil .. " -p 1;" .. blueutil .. " --connect Sicherung"
hs.hotkey.bindSpec({ HYPER_SHIFT, "b" }, function () hs.execute(blueutil_off)     end)
hs.hotkey.bindSpec({ HYPER,       "b" }, function () hs.execute(blueutil_connect) end)

-- Wifi -----------------------------------------------------------------------

wifi_interface = "en0"
hs.hotkey.bindSpec({ HYPER_SHIFT, "w" }, function () hs.wifi.setPower(false, wifi_interface) end)
hs.hotkey.bindSpec({ HYPER,       "w" }, function ()
	hs.wifi.setPower(true, wifi_interface)
	local dt = hs.wifi.availableNetworks(wifi_interface)
	if     ( dt["Utopie"] ~= nil ) then hs.wifi.associate("Utopie", "1997aaaaaa", wifi_interface)
	elseif ( dt["cos"]    ~= nil ) then hs.wifi.associate("cos",    "0906802822", wifi_interface)
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
