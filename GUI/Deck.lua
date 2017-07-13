local deck =
{
    visible = true
}

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
                    print(ht.deck.software.attack)
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
    
    deck.createStats()
    deck.createHardware()
    deck.createSoftware()
    
    imgui.End()
end

return deck
