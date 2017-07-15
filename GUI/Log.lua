local log =
{
    visible = true,
    scroll = false,
    
    messages = {}
}

function log.add(text, type)
    type = type or "normal"
    
    local message = {}
    
    message.text = text
    
    if type == "normal" then
        message.color = dgl.color.white
    elseif type == "warning" or type == "yellow" then
        message.color = dgl.color.yellow
    elseif type == "error" or type == "red" then
        message.color = dgl.color.red
    elseif type == "info" or type == "green" then
        message.color = dgl.color.green
    elseif type == "command" or type == "cyan" then
        message.color = dgl.color.cyan
    end
    
    table.insert(log.messages, message)
    
    log.scroll = true
end

function log.update()
    local status
    
    if not log.visible then return end
    
    imgui.SetNextWindowPos(100, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(400, 200)
    status, log.visible = imgui.Begin("Log", true, { "NoResize" })
    
    for i, message in ipairs(log.messages) do
        imgui.PushStyleColor("Text", message.color[1] / 255, message.color[2] / 255, message.color[3] / 255, message.color[4] / 255)
        imgui.PushTextWrapPos(0)
        imgui.TextWrapped(message.text)
        imgui.PopTextWrapPos()
        imgui.PopStyleColor()
    end
    
    if log.scroll then
        imgui.SetScrollHere(1)
        log.scroll = false
    end
    
    imgui.End()
end

return log
