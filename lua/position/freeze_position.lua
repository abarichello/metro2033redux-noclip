{$lua}
-- Prevent execution of Lua in aasm scripts during syntax check
if syntaxcheck then
    return
end

local asm = require "modules/asm"

local SCRIPTNAME = "freeze_position"
local FILE = "asm/position/freeze_position.asm"

setGlobalDelayBetweenHotkeyActivation(500) -- 500 ms

[ENABLE]
local enableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = FILE,
    enable = true,
}
asm.execute(enableInfo)

[DISABLE]
local disableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = FILE,
    enable = false,
}
asm.execute(disableInfo)
