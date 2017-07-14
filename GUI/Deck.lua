local deck =
{
    visible = true,
    
    integrityCanvas = love.graphics.newCanvas(380, 32),
    shieldCanvas = love.graphics.newCanvas(380, 32)
}

function deck.createIntegrity()
    local function drawIntegrityGraph()
        local percent = dgl.math.percent(ht.deck.integrity.current, ht.deck.integrity.max)
        
        love.graphics.setCanvas(deck.integrityCanvas)
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
        
        love.graphics.setPointSize(percent * 0.04)
        
        for x = 1, love.graphics.getCanvas():getWidth() do
            love.graphics.points(x, 15 + math.sin(x / 10 + (timer * (20 - (percent * 0.16)))) * 12)
            love.graphics.points(x, 15 + math.cos(x / 10 + (timer * (20 - (percent * 0.16)) + 96)) * 12)
        end
        
        love.graphics.setPointSize(1)
        love.graphics.setColor(unpack(dgl.color.white))
        love.graphics.setCanvas()
    end
    
    local function drawShieldGraph()
        local percent = dgl.math.percent(ht.deck.shield.current, ht.deck.shield.max)
        
        love.graphics.setCanvas(deck.shieldCanvas)
        love.graphics.clear(unpack(dgl.color.transparent))
        love.graphics.setColor(unpack(dgl.color.cyan))
        love.graphics.setPointSize(percent * 0.04)
        
        if ht.deck.shield.current > 0 then
            for x = 1, love.graphics.getCanvas():getWidth() do
                love.graphics.points(x, 16 + math.sin(timer + x) * 15)
            end
        end
        
        love.graphics.setPointSize(1)
        love.graphics.setColor(unpack(dgl.color.white))
        love.graphics.setCanvas()
    end
    
    if imgui.CollapsingHeader("Integrity", { "DefaultOpen" }) then
        drawIntegrityGraph()
        drawShieldGraph()
        
        imgui.Image(ht.data.images.integrity, 32, 32)
        imgui.SameLine()
        imgui.Text("Deck Integrity\n" .. ht.deck.integrity.current .. " / " .. ht.deck.integrity.max .. " (" .. math.ceil(dgl.math.percent(ht.deck.integrity.current, ht.deck.integrity.max)) .. "%%)")
        imgui.Image(deck.integrityCanvas, deck.integrityCanvas:getWidth(), deck.integrityCanvas:getHeight())
        
        imgui.Image(ht.data.images.armor, 32, 32)
        imgui.SameLine()
        imgui.Text("Deck Integrity Armor: " .. ht.deck.integrity.armor)
        
        imgui.Image(ht.data.images.shield, 32, 32)
        imgui.SameLine()
        if ht.deck.shield.max == 0 then
            imgui.Text("Deck Shield\nNone")
        else
            imgui.Text("Deck Shield\n" .. ht.deck.shield.current .. " / " .. ht.deck.shield.max .. " (" .. math.ceil(dgl.math.percent(ht.deck.shield.current, ht.deck.shield.max)) .. "%%)")
        end
        imgui.Image(deck.shieldCanvas, deck.shieldCanvas:getWidth(), deck.shieldCanvas:getHeight())
    end
end

function deck.createStats()
    if imgui.CollapsingHeader("Stats", { "DefaultOpen" }) then
        imgui.Image(ht.data.images.CPU, 32, 32)
        imgui.SameLine()
        imgui.Text("Central Processing Unit\nPower: " .. ht.deck.stats.power .. " GHz")
        imgui.Text("Usage: " .. ht.deck.usage.power .. " GHz")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.power, ht.deck.stats.power) / 100)
        
        imgui.Separator()
        
        imgui.Image(ht.data.images.placeholder, 32, 32)
        imgui.SameLine()
        imgui.Text("Sub Processing Unit\nThreads: " .. ht.deck.stats.threads)
        imgui.Text("Usage: " .. ht.deck.usage.threads)
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.threads, ht.deck.stats.threads) / 100)
        
        imgui.Separator()
        
        imgui.Image(ht.data.images.placeholder, 32, 32)
        imgui.SameLine()
        imgui.Text("Random Access Memory\nSize: " .. ht.deck.stats.RAM .. " GB")
        imgui.Text("Usage: " .. ht.deck.usage.RAM .. " GB")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.RAM, ht.deck.stats.RAM) / 100)
        
        imgui.Separator()
        
        imgui.Image(ht.data.images.placeholder, 32, 32)
        imgui.SameLine()
        imgui.Text("Hard Drive\nStorage: " .. ht.deck.stats.storage .. " GB")
        imgui.Text("Usage: " .. ht.deck.usage.storage .. " GB")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.storage, ht.deck.stats.storage) / 100)
        
        imgui.Separator()
        
        imgui.Image(ht.data.images.placeholder, 32, 32)
        imgui.SameLine()
        imgui.Text("Network Adapter\nBandwidth: " .. ht.deck.stats.bandwidth .. " GB/s")
    end
end

function deck.createHardware()
    local hardware =
    {
        { "CPU",       "CPU",       " GHz"     },
        { "SPU",       "SPU",       " Threads" },
        { "RAM",       "RAM",       " GB"      },
        { "Storage",   "storage",   " GB"      },
        { "Network",   "network",   " GB/s"    }
    }
    
    if imgui.CollapsingHeader("Hardware", { "DefaultOpen" }) then
        imgui.Indent()
        
        for i, type in pairs(hardware) do
            if imgui.CollapsingHeader(type[1] .. " (" .. #ht.deck.hardware[type[2]] .. "/" .. ht.deck.slots[type[2]] .. ")", { "DefaultOpen" }) then
                imgui.NewLine()
                
                for j, slot in ipairs(ht.deck.hardware[type[2]]) do
                    imgui.Image(ht.data.images.placeholder, 32, 32)
                    
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(slot .. type[3])
                    end
                    
                    if j % 8 == 0 then
                        imgui.NewLine()
                    else
                        imgui.SameLine()
                    end
                end
                
                imgui.NewLine()
                imgui.NewLine()
            end
        end
        
        imgui.Unindent()
    end
end

function deck.createSoftware()
    local categories =
    {
        "Attack",
        "Area Attack",
        "Defense",
        "Stealth",
        "Analysis",
        "Boost"
    }
    
    if imgui.CollapsingHeader("Software", { "DefaultOpen" }) then
        imgui.Indent()
        
        for i, category in ipairs(categories) do
            if imgui.CollapsingHeader(category, { "DefaultOpen" }) then
                imgui.Indent()
                imgui.NewLine()
                
                for j, type in ipairs(ht.data.software[i]) do
                    imgui.Image(ht.data.images.placeholder, 32, 32)
                    
                    if imgui.IsItemHovered() then
                        if ht.deck.software[type[2]].level == 0 then
                            imgui.SetTooltip(type[1])
                        else
                            imgui.SetTooltip(type[1] .. " " .. ht.deck.software[type[2]].level)
                        end
                    end
                    
                    local state = "Load"
                    if ht.deck.software[type[2]].loaded then
                        state = "Unload"
                    end
                    
                    if (ht.deck.software[type[2]].level > 0 or ht.player.stats.programming > 0) and imgui.BeginPopup("Software " .. type[1]) then
                        if ht.deck.software[type[2]].level > 0 and imgui.Selectable(state .. " Program") then
                            ht.deck.load(type[2])
                        end
                        
                        if ht.player.stats.programming > 0 and imgui.Selectable("Create Program") then
                            -- TODO
                        end
                        
                        imgui.EndPopup()
                    end
                    
                    if imgui.IsItemClicked(1) then
                        imgui.OpenPopup("Software " .. type[1])
                    end
                    
                    if j % 8 == 0 and j < #ht.data.software[i] then
                        imgui.NewLine()
                    else
                        imgui.SameLine()
                    end
                end
                
                imgui.NewLine()
                imgui.NewLine()
                imgui.Unindent()
            end
        end
        
        imgui.Unindent()
    end
end

function deck.update()
    local status
    
    if not deck.visible then return end
    
    imgui.SetNextWindowPos(480, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(400, 360)
    status, deck.visible = imgui.Begin("Deck", true, { "NoResize" })
    
    deck.createIntegrity()
    deck.createStats()
    deck.createHardware()
    deck.createSoftware()
    
    imgui.End()
end

return deck
