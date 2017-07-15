local mission =
{
    visible = true
}

function mission.update()
    local status
    local selected = 0
    
    if not mission.visible then return end
    
    imgui.SetNextWindowPos(500, 500, { "FirstUseEver" })
    imgui.SetNextWindowSize(600, 320)
    
    status, mission.visible = imgui.Begin("Missions", true, { "NoResize" })
    
    for i = 1, #ht.missions do
        if imgui.ImageButton(ht.data.images.placeholder, 32, 32) then
            selected = i
        end
        
        imgui.SameLine()
        imgui.Text(ht.missions[i].company .. " - " .. ht.missions[i].description .. "\nLevel " .. ht.missions[i].level .. ": " .. ht.missions[i].payment .. " C")
    end
    
    if selected > 0 then
        Mission.accept(selected)
        mission.visible = false
        ht.data.sounds.missionAccept:play()
    end
    
    imgui.End()
end

return mission
