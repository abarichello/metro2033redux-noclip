{$lua}
-- Prevent execution of Lua in aasm scripts during syntax check
if syntaxcheck then
    return
end

local BASE_ADDRESS = getAddress("metro.exe")
local Y_COORD_POINTER = "[[[[metro.exe + 00D01EB0] + E0] + 20] + 100] + F0"
local VK_W = 87
local VK_S = 83
local VK_LSHIFT = 160

function noclipFly()
    local speedModifier = 0.1
    if isKeyPressed(VK_LSHIFT) then
        speedModifier = speedModifier * 3
    end

    if isKeyPressed(VK_W) then
        local y = readFloat(Y_COORD_POINTER)
        writeFloat(Y_COORD_POINTER, y + speedModifier)
        print(y)
    end
    if isKeyPressed(VK_S) then
        local y = readFloat(Y_COORD_POINTER)
        writeFloat(Y_COORD_POINTER, y - speedModifier)
        print(y)
    end
end

[ENABLE]
noclipTimer = createTimer(getMainForm(), true)
noclipTimer.setInterval(15)
noclipTimer.setOnTimer(noclipFly)
noclipTimer.setEnabled(true)

[DISABLE]
if noclipTimer ~= nil then
    noclipTimer.destroy()
    noclipTimer = nil
end
