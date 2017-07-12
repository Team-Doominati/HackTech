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
        CPU = {},
        SPU = {},
        RAM = {},
        storage = {},
        network = {},
        expansion = {}
    },
    
    software = {}
}

function deck.update()
    -- TODO: keep stats up-to-date based on hardware
end

return deck
