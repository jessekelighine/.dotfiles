local M = {}

M.wifi_interface = "en0"

M.known_networks = {
	["Utopie"]          = "1997aaaaaa", -- Phone
	["sheep"]           = "1997aaaaaa", -- iPhone
	["EDIMAX"]          = "1997aaaaaa", -- NYC #41A
	["cos"]             = "0906802822", -- Room 645
	["RickyWramLin_5G"] = "room656656", -- Room 656
}

local M.keybind_wifi_switch = function(mappings, state)
	hs.hotkey.bindSpec(mappings, function () hs.wifi.setPower(state, M.wifi_interface) end)
end

hs.hotkey.bindSpec({ HYPER_SHIFT, "w" }, function () hs.wifi.setPower(false, wifi_interface) end)
hs.hotkey.bindSpec({ HYPER,       "w" }, function () hs.wifi.setPower(true,  wifi_interface) end)

return M
