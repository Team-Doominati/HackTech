local console =
{
    visible = false,
    
    width = 600,
    height = 300,
    
    bufferSize = 1024,
    
    log = "",
    command = ""
}

-- Redefine the print function to output to the console
if not _printRedefined then
    local _print = print

    local function ilines(s)
        if s:sub(-1) ~= "\n" then
            s = s .. "\n"
        end
        
        return s:gmatch("(.-)\n")
    end

    function print(...)
        local arg = { ... }
        local msg = ""

        for i, v in ipairs(arg) do
            msg = msg .. tostring(v)
            if type(v) == 'table' then
                for _k, _v in pairs(v) do
                    msg = msg .. "\n" .. tostring(_k) .. ": " .. tostring(_v)
                end
            end
        end

        for line in ilines(msg) do
            console.print(tostring(line))
            _print(line)
        end
    end

    _printRedefined = true
end

function console.print(text)
    console.log = console.log .. text .. "\n"
end

function console.input()
    print("> " .. console.command)
    
    local status, err = pcall(loadstring(console.command))
    if err ~= nil and #err > 0 then -- An error occured
        print("ERROR: " .. err)
    else
        print("OK")
    end
    
    console.command = ""
end

function console.update()
    local status
    
    if not console.visible then return end
    
    imgui.SetNextWindowPos(100, 100, "FirstUseEver")
    imgui.SetNextWindowSize(console.width, console.height)
    status, console.visible = imgui.Begin("Console", true, { "NoResize" })
    
    imgui.BeginChild("Log", console.width - 16, console.height - 56, false, { "AlwaysVerticalScrollbar" })
    imgui.TextWrapped(console.log)
    imgui.EndChild()
    imgui.PushItemWidth(console.width - 16)
    status, console.command = imgui.InputText("", console.command, console.bufferSize, { "EnterReturnsTrue" })
    
    if status then
        console.input()
    end
    
    imgui.End()
end

return console
