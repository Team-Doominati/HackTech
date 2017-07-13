local console =
{
    visible = false,
    scroll = false,
    
    width = 600,
    height = 300,
    
    bufferSize = 1024,
    
    messages = {},
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

function console.print(text, type)
    type = type or "normal"
    
    local message = {}
    
    message.text = text
    
    if type == "normal" then
        message.color = dgl.color.white
    elseif type == "warning" then
        message.color = dgl.color.yellow
    elseif type == "error" then
        message.color = dgl.color.red
    elseif type == "info" then
        message.color = dgl.color.green
    elseif type == "command" then
        message.color = dgl.color.cyan
    end
    
    table.insert(console.messages, message)
    
    console.scroll = true
end

function console.input()
    console.print("> " .. console.command, "command")
    
    local status, err = pcall(loadstring(console.command))
    if err ~= nil and #err > 0 then -- An error occured
        console.print("ERROR: " .. err, "error")
    else
        console.print("OK", "info")
    end
    
    console.command = ""
end

function console.update()
    local status
    
    if not console.visible then return end
    
    imgui.SetNextWindowPos(100, 100, "FirstUseEver")
    imgui.SetNextWindowSize(console.width, console.height)
    status, console.visible = imgui.Begin("Console", true, { "NoResize" })
    
    imgui.BeginChild("Messages", console.width - 16, console.height - 56, false)
    
    for i, message in ipairs(console.messages) do
        imgui.PushStyleColor("Text", message.color[1] / 255, message.color[2] / 255, message.color[3] / 255, message.color[4] / 255)
        imgui.PushTextWrapPos(0)
        imgui.TextWrapped(message.text)
        imgui.PopTextWrapPos()
        imgui.PopStyleColor()
    end
    
    if console.scroll then
        imgui.SetScrollHere(1)
        console.scroll = false
    end
    
    imgui.EndChild()
    
    imgui.PushItemWidth(console.width - 16)
    status, console.command = imgui.InputText("", console.command, console.bufferSize, { "EnterReturnsTrue" })
    
    if status then
        console.input()
    end
    
    imgui.End()
end

return console
