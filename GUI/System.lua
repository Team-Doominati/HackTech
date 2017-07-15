local system =
{
    visible = true
}

function system.createCurrentMission()
    local string = ""
    
    imgui.Image(ht.data.images.placeholder, 32, 32)
    imgui.SameLine()
    
    string = string .. "Target: " .. ht.player.mission.company .. "\n"
    string = string .. "Type: " .. ht.player.mission.description .. "\n"
    string = string .. "Level: " .. ht.player.mission.level .. "\n"
    string = string .. "Payment: " .. ht.player.mission.payment .. " C\n"
    string = string .. "Days Left: " .. ht.player.mission.deadline - ht.day .. "\n"
    string = string .. "Turn: " .. ht.system.turn
    
    imgui.Text(string)
    
    imgui.Indent(39)
    
    if ht.system.connected then
        if imgui.Button("Disconnect") then
            ht.system.disconnect()
        end
    else
        if imgui.Button("Connect") then
            ht.system.connect()
        end
    end
    
    imgui.SameLine()
    
    if imgui.Button("Abandon") then
        Mission.abandon()
    end
    
    imgui.Unindent()
end

function system.createFile(file)
    imgui.Image(ht.data.images.file, 32, 32)
    imgui.SameLine()
    imgui.Text(file.name .. "\nSize: " .. file.size .. " GB\nValue: " .. file.value .. " C")
end

function system.createIOP(IOP)
    if imgui.Button("Activate") then
        IOP:activate()
    end
end

function system.createSM(SM)
    if ht.system.alert ~= "none" and imgui.Button("Lower Alert Status") then
        SM:activate()
    end
end

function system.update()
    local status
    
    if not system.visible then return end
    
    imgui.SetNextWindowPos(500, 500, { "FirstUseEver" })
    imgui.SetNextWindowSize(360, 300)
    
    status, system.visible = imgui.Begin("System", true, { "NoResize" })
    
    if ht.player.mission ~= nil and ht.player.mission.accepted then
        system.createCurrentMission()
    end
    
    if ht.system.connected then
        for i, node in ipairs(ht.system.nodes) do
            if node.cleared then
                if node.type == "DS" and imgui.CollapsingHeader(node.name, { "DefaultOpen" }) then
                    for j, file in ipairs(node.files) do
                        system.createFile(file)
                    end
                elseif node.type == "IOP" and not node.activated and imgui.CollapsingHeader(node.name, { "DefaultOpen" }) then
                    system.createIOP(node)
                elseif node.type == "SM" and imgui.CollapsingHeader(node.name, { "DefaultOpen" }) then
                    system.createSM(node)
                elseif node.type == "CPU" and not node.activated and imgui.CollapsingHeader(node.name, { "DefaultOpen" }) then
                end
            end
        end
    end
    
    imgui.End()
end

return system
