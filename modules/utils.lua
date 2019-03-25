local u = {}

function u.log(message)
    print("--> asm.lua: " .. message)
end

-- Open Cheat Engine's auto assemble(.asm) scripts and return contents as a string
function u.open(path)
    local file = io.open(path, "r")
    if file == nil then
        log("Couldn't find file!")
        return
    end
    local content = file:read("*all")
    file:close()
    return content
end

-- Parse a .asm file, return only the section
-- [enable] if enable otherwise returns [disable] section
function u.extractSection(path, enable)
    local key = {start = nil, stop = nil}
    if enable then
        key.start = "[ENABLE]"
        key.stop = "[DISABLE]"
    else
        key.start = "[DISABLE]"
        key.stop = "[ENABLE]"
    end

    local script = ""
    local appendFlag = false
    for line in io.lines(path) do
        if line == key.start then
            appendFlag = true
        elseif line == key.stop then
            appendFlag = false
        elseif appendFlag then
            script = script .. line .. "\n"
        end
    end
    return script
end

return u
