local asm = {}

-- Table that constains all addresses of memory allocations made by cheat engine
-- Key: code cave symbol / Value: address of allocated memory
local memoryAddresses = {}

function log(message)
    print("--> asm.lua: " .. message)
end

-- Open Cheat Engine's auto assemble(*.asm) scripts and returns contents as a string
function asm.open(path)
    local file = io.open(path, "r")
    if file == nil then
        log("Couldn't find file!")
        return
    end
    local content = file:read("*all")
    file:close()
    return content
end

-- Function used for scripts that don't require allocating new memory
-- Parse a *.asm file, execute [enable] if info.enable, otherwise execute [disable]
function asm.execute(info)
    key = {
        start = "[ENABLE]",
        stop = "[DISABLE]"
    }
    if not enable then
        key.start = "[DISABLE]"
        key.stop = "[ENABLE]"
    end

    local script = ""
    local startFlag = false
    for line in io.lines(info.asmPath) do
        if line == key.stop then
            startFlag = false
        elseif line == key.start then
            startFlag = true
        elseif startFlag then
            script = script .. line .. "\n"
        end
    end
    autoAssemble(script)
end

-- Code cave related functions

-- Allocs memory inside the process, registers necessary user defined symbols
-- and executes the assembly script to create the code cave.
function asm.createCodeCave(info)
    log("Enabling script " .. info.asmPath)

    local caveSymbol = info.symbolPrefix .. "_cave"
    local addressSymbol = info.symbolPrefix .. "_nop"

    unregisterSymbol(caveSymbol)
    unregisterSymbol(addressSymbol)

    registerSymbol(addressSymbol, info.address)
    local caveMemAddress = allocateMemory(0x1000) -- 4KB
    registerSymbol(caveSymbol, caveMemAddress)
    memoryAddresses[caveSymbol] = caveMemAddress

    autoAssemble(asm.open(info.asmPath))
end

-- Unregisters all user defined symbols on enable.
-- Frees memory used in code cave.
function asm.destroyCodeCave(info)
    log("Disabling script " .. info.symbolPrefix)

    local caveSymbol = info.symbolPrefix .. "_cave"
    local addressSymbol = info.symbolPrefix .. "_nop"

    writeBytes(info.address, info.bytes)
    unregisterSymbol(caveSymbol)
    unregisterSymbol(addressSymbol)

    local caveMemAddress = memoryAddresses[caveSymbol]
    deAlloc(caveMemAddress, 0x1000) -- 4KB
    memoryAddresses[caveSymbol] = nil
end

return asm
