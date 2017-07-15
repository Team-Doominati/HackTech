local target =
{
    visible = false
}

function target.update()
    local status
    
    if not target.visible then return end
    
    imgui.SetNextWindowPos(100, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(300, 120)
    status, target.visible = imgui.Begin("Target", true, { "NoResize" })
    
    if ht.system.target ~= nil then
        local ICE = ht.system.target
        local string = ""
        
        imgui.Image(ICE.image, ICE.image:getWidth(), ICE.image:getHeight())
        string = string .. ICE.name .. "\n"
        
        if ICE.analyzed then
            string = string .. "Level: " .. ICE.level .. "\n"
            string = string .. "Integrity: " .. ICE.integrity .. "\n"
            string = string .. "Shield: " .. ICE.shield .. "\n"
            if ICE.state == "idle" or ICE.state == "spot" then
                string = string .. "Spot Chance: " .. ICE.stats.spot .. "%%\n"
                string = string .. "Deceive Chance: " .. ICE.stats.deceive .. "%%\n"
            elseif ICE.state == "attack" then
                
            end
        else
            string = string .. "<DATA UNKNOWN>" .. "\n"
            string = string .. "Analyze Chance: " .. ICE.stats.analyze .. "%%\n"
        end
        
        if ICE:isClear() then
            string = string .. "<CLEAR>\n"
        end
        
        imgui.SameLine()
        imgui.Text(string)
    end
    
    imgui.End()
end

return target
