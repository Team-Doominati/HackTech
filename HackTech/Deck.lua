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
        RAM = { 8 },
        storage = { 10 },
        network = { 1 },
        expansion = {}
    },
    
    software =
    {
        attack = 1,
        breaker = 0,
        pierce = 0,
        slice = 0,
        scramble = 0,
        virus = 0,
        slow = 0,
        confuse = 0,
        weaken = 0,
        overclock = 0,
        
        areaAttack = 0,
        areaBreaker = 0,
        areaPierce = 0,
        areaSlice = 0,
        areaScramble = 0,
        areaVirus = 0,
        areaSlow = 0,
        areaConfuse = 0,
        
        shield = 0,
        armor = 0,
        plating = 0,
        medic = 0,
        maintain = 0,
        regen = 0,
        nanogen = 0,
        reflect = 0,
        
        deceive = 1,
        relocate = 0,
        camo = 0,
        sleaze = 0,
        silence = 0,
        smoke = 0,
        
        analyze = 1,
        scan = 1,
        evaluate = 0,
        decrypt = 0,
        crack = 0,
        calculate = 0,
        bypass = 0,
        relay = 0,
        synthesize = 0,
        
        boostPassiveAttack = 0,
        boostPassiveDefense = 0,
        boostPassiveStealth = 0,
        boostPassiveAnalysis = 0,
        boostActiveAttack = 0,
        boostActiveDefense = 0,
        boostActiveStealth = 0,
        boostActiveAnalysis = 0
    }
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
