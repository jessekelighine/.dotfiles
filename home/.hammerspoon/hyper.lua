-----------------------------------------------------------------------------------
-- File: hyper.lua
-- Author: J.H. Kuperus
-- Source: https://github.com/jhkuperus/dotfiles/blob/master/hammerspoon/hyper.lua
-- "License": Feel free to use this file any way you like. Issues or improvements
--            are welcome on the GitHub repository. No warranties whatsoever.
-----------------------------------------------------------------------------------

-- To use Hyper in your init.lua script, import it and adapt this example to
-- your needs:
-- 
-- local hyper = require('hyper')
-- hyper.install('F18') 
-- hyper.bindkey('r', hs.reload)
--
-- The above three lines initialize Hyper to respond to F18 key-events and binds
-- Hyper+r to Hammerspoon Reload (easy way to refresh Hammerspoon's config)

-- Hyper mode needs to be bound to a key. Here we are binding
-- it to F17, because this is yet another key that's unused.
-- Why not F18? We will use key-events from F18 to turn hyper
-- mode on and off. Using F17 as the modal and source of key
-- events, will result in a very jittery Hyper mode.

-- To use F18 as Hyper key, we need to install the Karabiner-Elements
-- software and create a simple modification that maps some other key
-- (like the right_option key) to F18. See this article for details:
-- [blog post](https://medium.com/macoclock/solve-shortcut-hell-in-macos-building-a-hyper-key-1cb8838bf521).

local M = {}

M.hyperMode = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper) is pressed
local enterHyperMode = function()
	M.hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper) is pressed
local exitHyperMode = function()
	M.hyperMode:exit()
end

-- Utility to bind handler to Hyper+key
function M.bindKey(key, handler)
	M.hyperMode:bind({}, key, handler)
end

-- Utility to bind handler to Hyper+Shift+key
function M.bindShiftKey(key, handler)
	M.hyperMode:bind({'shift'}, key, handler)
end

-- Utility to bind handler to Hyper+Command+Shift+key
function M.bindCommandShiftKey(key, handler)
	M.hyperMode:bind({'command', 'shift'}, key, handler)
end

-- Utility to bind handler to Hyper+modifiers+key
function M.bindKeyWithModifiers(key, mods, handler)
	M.hyperMode:bind(mods, key, handler)
end

-- Binds the enter/exit functions of the Hyper modal to all combinations of modifiers
function M.install(hotKey)
	hs.hotkey.bind({}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"ctrl"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"cmd"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"cmd", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "ctrl", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "cmd"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "cmd", "shift"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "cmd", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
	hs.hotkey.bind({"alt", "cmd", "shift", "ctrl"}, hotKey, enterHyperMode, exitHyperMode)
end

return M
