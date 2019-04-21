{$lua}
-- Prevent execution of Lua in aasm scripts during syntax check
if syntaxcheck then
    return
end

local asm = require "modules/asm"

local SCRIPTNAME = "noclip"
local PATH = "asm/position/noclip.asm"

[ENABLE]
local enableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = PATH,
    enable = true,
}
asm.execute(enableInfo)

[DISABLE]
local disableInfo = {
    scriptName = SCRIPTNAME,
    asmPath = PATH,
    enable = false,
}
asm.execute(disableInfo)
