{$lua}
-- Prevent execution of Lua in aasm scripts during syntax check
if syntaxcheck then
    return
end

local asm = require "modules/asm"

local SCRIPTNAME = "freeze_position"
local FILE = "asm/position/freeze_position.asm"

[ENABLE]
enableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = FILE,
    enable = true,
}

[DISABLE]
enableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = FILE,
    enable = false,
}

