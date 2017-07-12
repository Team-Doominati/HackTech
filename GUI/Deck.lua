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
                imgui.NewLine()
                
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
    
    local software =
    {
        {
            { "Attack", "attack" },
            { "Break", "breaker" },
            { "Pierce", "pierce" },
            { "Slice", "slice" },
            { "Scramble", "scramble" },
            { "Virus", "virus" },
            { "Slow", "slow" },
            { "Confuse", "confuse" },
            { "Weaken", "weaken" },
            { "Overclock", "overclock" }
        },
        
        {
            { "Area Attack", "areaAttack" },
            { "Area Break", "areaBreaker" },
            { "Area Pierce", "areaPierce" },
            { "Area Slice", "areaSlice" },
            { "Area Scramble", "areaScramble" },
            { "Area Virus", "areaVirus" },
            { "Area Slow", "areaSlow" },
            { "Area Confuse", "areaConfuse" }
        },
        
        {
            { "Shield", "shield" },
            { "Armor", "armor" },
            { "Plating", "plating" },
            { "Medic", "medic" },
            { "Maintain", "maintain" },
            { "Regen", "regen" },
            { "Nanogen", "nanogen" },
            { "reflect", "reflect" }
        },
        
        {
            { "Deceive", "deceive" },
            { "Relocate", "relocate" },
            { "Camo", "camo" },
            { "Sleaze", "sleaze" },
            { "Silence", "silence" },
            { "Smoke", "smoke" }
        },
        
        {
            { "Analyze", "analyze" },
            { "Scan", "scan" },
            { "Evaluate", "evaluate" },
            { "Decrypt", "decrypt" },
            { "Crack", "crack" },
            { "Calculate", "calculate" },
            { "Bypass", "bypass" },
            { "Relay", "relay" },
            { "Synthesize", "synthesize" }
        },
        
        {
            { "Boost Attack (Passive)", "boostPassiveAttack" },
            { "Boost Defense (Passive)", "boostPassiveDefense" },
            { "Boost Stealth (Passive)", "boostPassiveStealth" },
            { "Boost Analysis (Passive)", "boostPassiveAnalysis" },
            { "Boost Attack (Active)", "boostActiveAttack" },
            { "Boost Defense (Active)", "boostActiveDefense" },
            { "Boost Stealth (Active)", "boostActiveStealth" },
            { "Boost Analysis (Active)", "boostActiveAnalysis" }
        }
    }
    
    if imgui.CollapsingHeader("Software", { "DefaultOpen" }) then
        imgui.Indent()
        
        for i, category in ipairs(categories) do
            if imgui.CollapsingHeader(category, { "DefaultOpen" }) then
                imgui.Indent()
                imgui.NewLine()
                
                for j, type in ipairs(software[i]) do
                    imgui.Image(deck.images.place, 32, 32)
                    
                    if imgui.IsItemHovered() then
                        if ht.deck.software[type[2]] == 0 then
                            imgui.SetTooltip(type[1])
                        else
                            imgui.SetTooltip(type[1] .. " " .. ht.deck.software[type[2]])
                        end
                    end
                    
                    if j % 8 == 0 and j < #software[i] then
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
    
    deck.createStats()
    deck.createHardware()
    deck.createSoftware()
    
    imgui.End()
end

return deck
