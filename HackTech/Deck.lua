local deck =
{
    stats =
    {
        power = 0,
        threads = 0,
        RAM = 0,
        storage = 0,
        bandwidth = 0
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
        SPU = { 1 },
        RAM = { 8 },
        storage = { 10 },
        network = { 1 },
        expansion = { 1 }
    },
    
    software = {}
}

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
    for i, v in ipairs(deck.hardware.RAM) do
        deck.stats.RAM = deck.stats.RAM + v
    end
    
    deck.stats.storage = 0
    for i, v in ipairs(deck.hardware.storage) do
        deck.stats.storage = deck.stats.storage + v
    end
    
    deck.stats.bandwidth = 0
    for i, v in ipairs(deck.hardware.network) do
        deck.stats.bandwidth = deck.stats.bandwidth + v
    end
end

return deck
