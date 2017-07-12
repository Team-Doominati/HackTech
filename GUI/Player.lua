local player = 
{
    visible = true,
    
    images =
    {
        place = love.graphics.newImage("Data/GUI/Placeholder.png"),
        heartGreen = love.graphics.newImage("Data/GUI/HeartGreen.png"),
        heartRed = love.graphics.newImage("Data/GUI/HeartRed.png")
    },
    
    sounds =
    {
        upgrade = love.audio.newSource("Data/Sound/UpgradeStat.wav", "static")
    }
}

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
        imgui.Text("Level: " .. ht.player.stats.level)
        imgui.Text("XP: " .. ht.player.stats.XP .. " / " .. ht.player.getLevelNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.stats.XP, ht.player.getLevelNext()))
        imgui.Text("Stat Points: " .. ht.player.stats.points)
        imgui.Separator()
        
        for i, stat in pairs(stats) do
            local type = string.lower(stat)
            
            imgui.Image(player.images.place, 32, 32)
            imgui.SameLine()
            imgui.AlignFirstTextHeightToWidgets()
            imgui.Text(stat .. ": " .. ht.player.stats[type])
            
            if ht.player.canUpgradeStat(type) then
                imgui.SameLine()
                
                if imgui.Button("Upgrade " .. stat) then
                    ht.player.upgradeStat(type)
                    player.sounds.upgrade:play()
                end
            end
        end
    end
end

function player.createRep()
    if imgui.CollapsingHeader("Reputation", { "DefaultOpen" }) then
        imgui.Text("Level: " .. ht.player.rep.level)
        imgui.Text("XP: " .. ht.player.rep.XP .. " / " .. ht.player.getRepNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.rep.XP, ht.player.getRepNext()))
    end
end

function player.createHealth()
    if imgui.CollapsingHeader("Health", { "DefaultOpen" }) then
        local mentHealthPlot = {}
        local physHealthPlot = {}
        
        for i = 1, 60 do
            local percent = ht.player.health.mental / 5
            local offset = timer * (30 - percent) + i
            
            mentHealthPlot[i] = 0.5 + math.sin(offset) * 0.5
        end
        
        -- TODO: Make this actually work properly
        for i = 1, 60 do
            local percent = ht.player.health.physical / 5
            local offset = timer * (30 - percent) + i
            
            physHealthPlot[i] = lume.round(math.sin(offset))
        end
        
        imgui.Image(player.images.heartGreen, 32, 32)
        imgui.SameLine()
        imgui.Text("Mental Health: " .. ht.player.health.mental .. "%%")
        imgui.PlotLines("", mentHealthPlot, #mentHealthPlot, 0, "", 0, 1, 340, 32)
        
        imgui.Image(player.images.heartRed, 32, 32)
        imgui.SameLine()
        imgui.Text("Physical Health: " .. ht.player.health.physical .. "%%")
        imgui.PlotLines("", physHealthPlot, #physHealthPlot, 0, "", 0, 1, 340, 32)
    end
end

function player.createMoney()
    if imgui.CollapsingHeader("Money", { "DefaultOpen" }) then
        imgui.Text("Credits: " .. ht.player.credits .. " C")
        
        imgui.Separator()
        imgui.Indent()
        
        if imgui.CollapsingHeader("Payments", { "DefaultOpen" }) then
            imgui.Text("Living Expenses: " .. ht.player.payment.living .. " C")
            imgui.Text("Software Licenses: " .. ht.player.payment.software .. " C")
            imgui.Text("Hardware Maintenance: " .. ht.player.payment.hardware .. " C")
            imgui.Text("Medical Care: " .. ht.player.payment.medical .. " C")
            imgui.Text("Fines: " .. ht.player.payment.fine .. " C")
            
            imgui.Spacing()
            
            imgui.Text("Total: " .. ht.player.getTotalPayment() .. " C")
            
            imgui.Spacing()
            
            if ht.player.getPaymentDays() <= 1 then
                imgui.Text("Due in: " .. ht.player.getPaymentDays() .. " Day")
            else
                imgui.Text("Due in: " .. ht.player.getPaymentDays() .. " Days")
            end
        end
        
        imgui.Unindent()
    end
end

function player.update()
    local status
    
    if not player.visible then return end
    
    imgui.SetNextWindowPos(100, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(360, 360)
    status, player.visible = imgui.Begin(ht.player.name, true, { "NoResize" })
    
    player.createStats()
    player.createRep()
    player.createHealth()
    player.createMoney()
    
    imgui.End()
end

return player
