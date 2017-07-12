local deck =
{
    visible = true,
    
    images =
    {
        place = love.graphics.newImage("Data/GUI/Placeholder.png"),
        CPU = love.graphics.newImage("Data/GUI/CPU.png"),
        SPU = love.graphics.newImage("Data/GUI/Placeholder.png"),
        RAM = love.graphics.newImage("Data/GUI/Placeholder.png"),
        storage = love.graphics.newImage("Data/GUI/Placeholder.png"),
        network = love.graphics.newImage("Data/GUI/Placeholder.png"),
        expansion = love.graphics.newImage("Data/GUI/Placeholder.png")
    }
}

function deck.createStats()
    if imgui.CollapsingHeader("Stats", { "DefaultOpen" }) then
        imgui.Image(deck.images.CPU, 32, 32)
        imgui.SameLine()
        imgui.Text("Central Processing Unit\nPower: " .. ht.deck.stats.power .. " GHz")
        imgui.Text("Usage: " .. ht.deck.usage.power .. " GHz")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.power, ht.deck.stats.power))
        
        imgui.Separator()
        
        imgui.Image(deck.images.place, 32, 32)
        imgui.SameLine()
        imgui.Text("Sub Processing Unit\nThreads: " .. ht.deck.stats.threads)
        imgui.Text("Usage: " .. ht.deck.usage.threads)
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.threads, ht.deck.stats.threads))
        
        imgui.Separator()
        
        imgui.Image(deck.images.place, 32, 32)
        imgui.SameLine()
        imgui.Text("Random Access Memory\nSize: " .. ht.deck.stats.RAM .. " GB")
        imgui.Text("Usage: " .. ht.deck.usage.RAM .. " GB")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.RAM, ht.deck.stats.RAM))
        
        imgui.Separator()
        
        imgui.Image(deck.images.place, 32, 32)
        imgui.SameLine()
        imgui.Text("Hard Drive\nStorage: " .. ht.deck.stats.storage .. " GB")
        imgui.Text("Usage: " .. ht.deck.usage.storage .. " GB")
        imgui.ProgressBar(dgl.math.percent(ht.deck.usage.storage, ht.deck.stats.storage))
        
        imgui.Separator()
        
        imgui.Image(deck.images.place, 32, 32)
        imgui.SameLine()
        imgui.Text("Network Adapter\nBandwidth: " .. ht.deck.stats.bandwidth .. " GB/s")
    end
end

function deck.createHardware()
    local hardware =
    {
        { "CPU",       "CPU",       " GHz"  },
        { "SPU",       "SPU",       ""      },
        { "RAM",       "RAM",       " GB"   },
        { "Storage",   "storage",   " GB"   },
        { "Network",   "network",   " GB/s" }
    }
    
    if imgui.CollapsingHeader("Hardware", { "DefaultOpen" }) then
        imgui.Indent()
        
        for i, type in pairs(hardware) do
            if imgui.CollapsingHeader(type[1] .. " (" .. #ht.deck.hardware[type[2]] .. "/" .. ht.deck.slots[type[2]] .. ")", { "DefaultOpen" }) then
                for j, slot in ipairs(ht.deck.hardware[type[2]]) do
                    imgui.Image(deck.images[type[2]], 32, 32)
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(slot .. type[3])
                    end
                    
                    if j % 8 == 0 then
                        imgui.NewLine()
                    else
                        imgui.SameLine()
                    end
                end
            end
            
            imgui.NewLine()
            imgui.NewLine()
        end
        
        imgui.Unindent()
    end
end

function deck.createSoftware()
    if imgui.CollapsingHeader("Software", { "Software" }) then
    end
end

function deck.update()
    local status
    
    if not deck.visible then return end
    
    imgui.SetNextWindowPos(480, 100, { "FirstUseEver" })
    imgui.SetNextWindowSize(400, 360)
    status, deck.visible = imgui.Begin("Deck", true, { "NoResize" })
    
    deck.createStats()
    deck.createHardware()
    deck.createSoftware()
    
    imgui.End()
end

return deck
