local player = 
{
    visible = true,
    
    mentalHealthCanvas = love.graphics.newCanvas(340, 32),
    physicalHealthCanvas = love.graphics.newCanvas(340, 32)
}

function player.createHealth()
    local function drawMentalEKG()
        local percent = dgl.math.percent(ht.player.health.mental, ht.player.health.mentalMax)
        
        love.graphics.setCanvas(player.mentalHealthCanvas)
        love.graphics.clear(unpack(dgl.color.transparent))
        
        if percent >= 75 then
            love.graphics.setColor(unpack(dgl.color.green))
        elseif percent >= 50 and percent <= 74 then
            love.graphics.setColor(unpack(dgl.color.yellow))
        elseif percent >= 25 and percent <= 49 then
            love.graphics.setColor(unpack(dgl.color.orange))
        elseif percent < 25 then
            love.graphics.setColor(unpack(dgl.color.red))
        end
        
        for x = 1, love.graphics.getCanvas():getWidth() do
            love.graphics.points(x, 15 + math.sin(x / 10 + (timer * (20 - (percent * 0.16)))) * 15)
        end
        
        love.graphics.setColor(unpack(dgl.color.white))
        love.graphics.setCanvas()
    end
    
    local function drawPhysicalEKG()
        local percent = dgl.math.percent(ht.player.health.physical, ht.player.health.physicalMax)
        local gap = 30 + percent * 0.6
        local offset = -((timer * 10) % gap * 4)
        
        love.graphics.setCanvas(player.physicalHealthCanvas)
        love.graphics.clear(unpack(dgl.color.transparent))
        
        if percent >= 75 then
            love.graphics.setColor(unpack(dgl.color.green))
        elseif percent >= 50 and percent <= 74 then
            love.graphics.setColor(unpack(dgl.color.yellow))
        elseif percent >= 25 and percent <= 49 then
            love.graphics.setColor(unpack(dgl.color.orange))
        elseif percent < 25 then
            love.graphics.setColor(unpack(dgl.color.red))
        end
        
        for x = 0, 360 * 2, gap do
            love.graphics.line(x + offset, 16, x - gap + offset + 15, 16)
            love.graphics.line(x + gap + offset, 16, x + gap + offset + 5, 0)
            love.graphics.line(x + gap + offset + 5, 0, x + gap + offset + 10, 32)
            love.graphics.line(x + gap + offset + 10, 32, x + gap + offset + 15, 16)
        end
        
        love.graphics.setColor(unpack(dgl.color.white))
        love.graphics.setCanvas()
    end
    
    if imgui.CollapsingHeader("Health", { "DefaultOpen" }) then
        drawMentalEKG()
        drawPhysicalEKG()
        
        imgui.Image(ht.data.images.heartGreen, 32, 32)
        imgui.SameLine()
        imgui.Text("Mental Health\n" .. ht.player.health.mental .. " / " .. ht.player.health.mentalMax .. " (" .. math.ceil(dgl.math.percent(ht.player.health.mental, ht.player.health.mentalMax)) .. "%%)")
        imgui.Image(player.mentalHealthCanvas, player.mentalHealthCanvas:getWidth(), player.mentalHealthCanvas:getHeight())
        
        imgui.Image(ht.data.images.heartRed, 32, 32)
        imgui.SameLine()
        imgui.Text("Physical Health\n" .. ht.player.health.physical .. " / " .. ht.player.health.physicalMax .. " (" .. math.ceil(dgl.math.percent(ht.player.health.physical, ht.player.health.physicalMax)) .. "%%)")
        imgui.Image(player.physicalHealthCanvas, player.physicalHealthCanvas:getWidth(), player.physicalHealthCanvas:getHeight())
    end
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
        imgui.Text("Level: " .. ht.player.stats.level)
        imgui.Text("XP: " .. ht.player.stats.XP .. " / " .. ht.player.getLevelNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.stats.XP, ht.player.getLevelNext()))
        imgui.Text("Stat Points: " .. ht.player.stats.points)
        imgui.Separator()
        
        for i, stat in pairs(stats) do
            local type = string.lower(stat)
            
            imgui.Image(ht.data.images.placeholder, 32, 32)
            imgui.SameLine()
            imgui.AlignFirstTextHeightToWidgets()
            imgui.Text(stat .. ": " .. ht.player.stats[type])
            
            if ht.player.canUpgradeStat(type) then
                imgui.SameLine()
                
                if imgui.Button("Upgrade " .. stat) then
                    ht.player.upgradeStat(type)
                    ht.data.sounds.statUpgrade:play()
                end
            end
        end
    end
end

function player.createRep()
    if imgui.CollapsingHeader("Reputation", { "DefaultOpen" }) then
        imgui.Text("Level: " .. ht.player.rep.level)
        imgui.Text("XP: " .. ht.player.rep.XP .. " / " .. ht.player.getRepNext())
        imgui.ProgressBar(dgl.math.percent(ht.player.rep.XP, ht.player.getRepNext()) / 100)
    end
end

function player.createMoney()
    if imgui.CollapsingHeader("Money", { "DefaultOpen" }) then
        if ht.player.credits < 0 then
            imgui.PushStyleColor("Text", dgl.color.red[1] / 255, dgl.color.red[2] / 255, dgl.color.red[3] / 255, dgl.color.red[4] / 255)
        end
        imgui.Text("Credits: " .. ht.player.credits .. " C")
        if ht.player.credits < 0 then
            imgui.PopStyleColor()
        end
        
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
    
    imgui.Text("Day " .. ht.day)
    
    player.createHealth()
    player.createStats()
    player.createRep()
    player.createMoney()
    
    imgui.End()
end

return player
