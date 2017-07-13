local mission =
{
    visible = true
}

function mission.createMissions()
    local selected = 0
    
    for i = 1, #ht.missions do
        if imgui.ImageButton(ht.data.images.placeholder, 32, 32) then
            selected = i
        end
        
        imgui.SameLine()
        imgui.Text(ht.missions[i].company .. " - " .. ht.missions[i].description .. "\nLevel " .. ht.missions[i].level .. ": " .. ht.missions[i].payment .. " C")
    end
    
    if selected > 0 then
        ht.player.acceptMission(selected)
        ht.data.sounds.missionAccept:play()
    end
end

function mission.createCurrentMission()
    imgui.Image(ht.data.images.placeholder, 32, 32)
    imgui.SameLine()
    imgui.Text("Target: " .. ht.player.mission.company .. "\nType: " .. ht.player.mission.description .. "\nLevel: " .. ht.player.mission.level .. "\nPayment: " .. ht.player.mission.payment .. " C")
end

function mission.update()
    local status
    
    if not mission.visible then return end
    
    imgui.SetNextWindowPos(500, 500, { "FirstUseEver" })
    
    if ht.player.mission.accepted then
        imgui.SetNextWindowSize(600, 86)
    else
        imgui.SetNextWindowSize(600, 320)
    end
    
    status, mission.visible = imgui.Begin("Missions", true, { "NoResize" })
    
    if ht.player.mission.accepted then
        mission.createCurrentMission()
    else
        mission.createMissions()
    end
    
    imgui.End()
end

return mission
