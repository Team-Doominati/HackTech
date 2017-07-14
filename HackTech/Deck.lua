local deck =
{
    integrity =
    {
        current = 100,
        max = 100,
        armor = 0
    },
    
    shield =
    {
        current = 0,
        max = 0
    },
    
    stats =
    {
        power = 0,
        threads = 0,
        RAM = 0,
        storage = 0,
        bandwidth = 0
    },
    
    usage =
    {
        power = 0,
        threads = 0,
        RAM = 0,
        storage = 0
    },
    
    slots =
    {
        CPU = 1,
        SPU = 1,
        RAM = 1,
        storage = 1,
        network = 1,
        expansion = 0
    },
    
    hardware =
    {
        CPU = { 1 },
        SPU = { 4 },
        RAM = { 4 },
        storage = { 8 },
        network = { 1 },
        expansion = {}
    },
    
    software = {}
}

function deck.initialize()
    for i, category in ipairs(ht.data.software) do
        for j, type in ipairs(ht.data.software[i]) do
            deck.software[type[2]] = Software:new(type[2])
        end
    end
    
    deck.software.attack.level = 1
    deck.software.deceive.level = 1
    deck.software.analyze.level = 1
    deck.software.scan.level = 1
    deck.software.attack.loaded = true
    deck.software.deceive.loaded = true
    deck.software.analyze.loaded = true
    deck.software.scan.loaded = true
end

function deck.update()
    deck.stats.power = 0
    for i, v in ipairs(deck.hardware.CPU) do
        deck.stats.power = deck.stats.power + v
    end
    
    deck.stats.threads = 0
    for i, v in ipairs(deck.hardware.SPU) do
        deck.stats.threads = deck.stats.threads + v
    end
    
    deck.stats.RAM = 0
    deck.usage.RAM = 0
    for i, v in ipairs(deck.hardware.RAM) do
        deck.stats.RAM = deck.stats.RAM + v
    end
    for k, software in pairs(deck.software) do
        if software.loaded then
            deck.usage.RAM = deck.usage.RAM + software:getSize()
        end
    end
    
    deck.stats.storage = 0
    deck.usage.storage = 0
    for i, v in ipairs(deck.hardware.storage) do
        deck.stats.storage = deck.stats.storage + v
    end
    for k, software in pairs(deck.software) do
        deck.usage.storage = deck.usage.storage + software:getSize()
    end
    
    deck.stats.bandwidth = 0
    for i, v in ipairs(deck.hardware.network) do
        deck.stats.bandwidth = deck.stats.bandwidth + v
    end
end

function deck.load(type)
    if deck.software[type].loaded then
        deck.software[type].loaded = false
        ht.data.sounds.softwareUnload:play()
    elseif deck.usage.RAM + deck.software[type]:getSize() <= deck.stats.RAM then
        deck.software[type].loaded = true
        ht.data.sounds.softwareLoad:play()
    else
        ht.data.sounds.softwareFail:play()
    end
end

return deck
