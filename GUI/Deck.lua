local deck =
{
    visible = true,
    
    placeImage = love.graphics.newImage("Data/GUI/Placeholder.png"),
    CPUImage = love.graphics.newImage("Data/GUI/CPU.png")
}

function deck.createStats()
    if imgui.CollapsingHeader("Stats", { "DefaultOpen" }) then
        imgui.Image(deck.CPUImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Power: " .. ht.deck.stats.power .. " GHz")
        imgui.Image(deck.placeImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Threads: " .. ht.deck.stats.threads)
        imgui.Image(deck.placeImage, 32, 32)
        imgui.SameLine()
        imgui.Text("RAM: " .. ht.deck.stats.RAM .. " GB")
        imgui.Image(deck.placeImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Storage: " .. ht.deck.stats.storage .. " GB")
        imgui.Image(deck.placeImage, 32, 32)
        imgui.SameLine()
        imgui.Text("Bandwidth: " .. ht.deck.stats.bandwidth .. " GB/s")
    end
end

function deck.createHardware()
    if imgui.CollapsingHeader("Hardware", { "DefaultOpen" }) then
        imgui.Indent()
        
        if imgui.CollapsingHeader("CPU", { "DefaultOpen" }) then
        end
        if imgui.CollapsingHeader("SPU", { "DefaultOpen" }) then
        end
        if imgui.CollapsingHeader("RAM", { "DefaultOpen" }) then
        end
        if imgui.CollapsingHeader("Storage", { "DefaultOpen" }) then
        end
        if imgui.CollapsingHeader("Network", { "DefaultOpen" }) then
        end
        if imgui.CollapsingHeader("Expansion", { "DefaultOpen" }) then
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
    
    imgui.SetNextWindowPos(480, 100)
    imgui.SetNextWindowSize(400, 360)
    status, deck.visible = imgui.Begin("Deck", true, { "NoResize" })
    
    deck.createStats()
    deck.createHardware()
    deck.createSoftware()
    
    imgui.End()
end

return deck
