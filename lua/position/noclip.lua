{$lua}
-- Prevent execution of Lua in aasm scripts during syntax check
if syntaxcheck then
    return
end

local X_COORD_POINTER = "[[[[metro.exe + 00D01EB0] + E0] + 20] + 100] + E8"
local Z_COORD_POINTER = "[[[[metro.exe + 00D01EB0] + E0] + 20] + 100] + EC"
local Y_COORD_POINTER = "[[[[metro.exe + 00D01EB0] + E0] + 20] + 100] + F0"

function noclipFly()
    local speedModifier = 0.1
    if isKeyPressed(VK_LSHIFT) then
        speedModifier = speedModifier * 3
    end

    -- X Coordinate
    if isKeyPressed(VK_D) then
        local x = readFloat(X_COORD_POINTER)
        writeFloat(X_COORD_POINTER, x + speedModifier)
    end
    if isKeyPressed(VK_A) then
        local x = readFloat(X_COORD_POINTER)
        writeFloat(X_COORD_POINTER, x - speedModifier)
    end

    -- Z Coordinate
    if isKeyPressed(VK_E) then
        local z = readFloat(Z_COORD_POINTER)
        writeFloat(Z_COORD_POINTER, z + speedModifier)
    end
    if isKeyPressed(VK_Q) then
        local z = readFloat(Z_COORD_POINTER)
        writeFloat(Z_COORD_POINTER, z - speedModifier)
    end

    -- Y Coordinate
    if isKeyPressed(VK_W) then
        local y = readFloat(Y_COORD_POINTER)
        writeFloat(Y_COORD_POINTER, y + speedModifier)
    end
    if isKeyPressed(VK_S) then
        local y = readFloat(Y_COORD_POINTER)
        writeFloat(Y_COORD_POINTER, y - speedModifier)
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
