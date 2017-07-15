local target =
{
    visible = false
}

function target.update()
    local status
    
    if not target.visible then return end
    
    imgui.SetNextWindowPos(100, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(200, 200)
    status, target.visible = imgui.Begin("Target", true, { "NoResize" })
    
    imgui.End()
end

return target
