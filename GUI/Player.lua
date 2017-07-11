local player = 
{
    visible = true,
    
    placeImage = love.graphics.newImage("Data/GUI/Placeholder.png"),
    heartGreenImage = love.graphics.newImage("Data/GUI/HeartGreen.png"),
    heartRedImage = love.graphics.newImage("Data/GUI/HeartRed.png")
}

function player.toggle()
    player.visible = not player.visible
end

function player.createStats()
    local stats =
    {
        "Attack",
        "Defense",
        "Stealth",
        "Analysis",
        "Programming",
        "Engineering",
        "Negotiation"
    }
    
    if imgui.CollapsingHeader("Stats", { "DefaultOpen" }) then
        imgui.Text("Level: " .. ht.player.level)
        imgui.Text("XP: " .. ht.player.XP .. " / " .. ht.player.getLevelNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.XP, ht.player.getLevelNext()))
        imgui.Text("Stat Points: " .. ht.player.points)
        imgui.Separator()
        
        for i, v in pairs(stats) do
            local type = string.lower(v)
            
            imgui.Image(player.placeImage, 32, 32)
            imgui.SameLine()
            imgui.AlignFirstTextHeightToWidgets()
            imgui.Text(v .. ": " .. ht.player[type])
            
            if ht.player.canUpgradeStat(type) then
                imgui.SameLine()
                
                if imgui.Button("Upgrade " .. v) then
                    ht.player.upgradeStat(type)
                end
            end
        end
    end
end

function player.createRep()
    if imgui.CollapsingHeader("Reputation", { "DefaultOpen" }) then
        imgui.Text("Level: " .. ht.player.repLevel)
        imgui.Text("XP: " .. ht.player.rep .. " / " .. ht.player.getRepNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.rep, ht.player.getRepNext()))
    end
end

function player.createHealth()
    if imgui.CollapsingHeader("Health", { "DefaultOpen" }) then
        local mentHealthPlot = {}
        local physHealthPlot = {}
        
        for i = 1, 20 do
            local percent = ht.player.mentHealth / 2
            local offset = timer * (60 - percent) + i
            
            mentHealthPlot[i] = 0.5 + math.sin(offset) * 0.5
        end
        
        for i = 1, 20 do
            local percent = ht.player.physHealth / 2
            local offset = timer + i -- timer * (60 - percent) + i
            
            physHealthPlot[i] = 1 - math.abs(offset % 4)
        end
        
        imgui.Image(player.heartGreenImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Mental Health: " .. ht.player.mentHealth .. "%%")
        imgui.PlotLines("", mentHealthPlot, #mentHealthPlot, 0, "", 0, 1, 340, 32)
        
        imgui.Image(player.heartRedImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Physical Health: " .. ht.player.physHealth .. "%%")
        imgui.PlotLines("", physHealthPlot, #physHealthPlot, 0, "", 0, 1, 340, 32)
    end
end

function player.createMoney()
    if imgui.CollapsingHeader("Money", { "DefaultOpen" }) then
        imgui.Text("Credits: " .. ht.player.credits)
    end
end

function player.update()
    local status
    
    if not player.visible then return end
    
    imgui.SetNextWindowPos(100, 100, "FirstUseEver")
    imgui.SetNextWindowSize(360, 360)
    status, player.visible = imgui.Begin(ht.player.name, true, { "NoResize" })
    
    player.createStats()
    player.createRep()
    player.createHealth()
    player.createMoney()
    
    imgui.End()
end

return player