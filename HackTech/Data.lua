local data =
{
    fonts = {},
    images = {},
    sounds = {},
    
    company = {},
    
    mission =
    {
        {
            type = "steal",
            description = "Steal Files"
        },
        {
            type = "erase",
            description = "Erase Files"
        },
        {
            type = "stealErase",
            description = "Steal and Erase Files"
        },
        {
            type = "activate",
            description = "Activate I/O"
        },
        {
            type = "backdoor",
            description = "Install Backdoor"
        },
        {
            type = "crash",
            description = "Crash System"
        },
        {
            type = "clear",
            description = "Clear all ICE"
        }
    },
    
    software =
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
            { "Reflect", "reflect" }
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
}

function data.load()
    local extensions =
    {
        font = { "ttf", "otf" },
        image = { "png" },
        sound = { "wav", "ogg" }
    }
    
    local loaders =
    {
        font = data.loadFont,
        image = data.loadImage,
        sound = data.loadSound
    }
    
    local dir = "Data/"
    local dirs = love.filesystem.getDirectoryItems(dir)
    
    for i = 1, #dirs do
        local files = love.filesystem.getDirectoryItems(dir .. dirs[i])
        
        for j = 1, #files do
            local loaded = false
            local path = dir .. dirs[i] .. "/" .. files[j]
            local ext = path:sub(-3)
            
            for k, v in pairs(extensions) do
                for l = 1, #extensions[k] do
                    if ext == extensions[k][l] then
                        local split = lume.split(path, '/')
                        local name = lume.split(split[#split], '.')[1]
                        
                        loaders[k](path, name)
                        loaded = true
                    end
                end
            end
            
            --[[
            if loaded then
                print("Loading " .. path)
            else
                print("Error loading " .. path .. ": unknown resource type!")
            end
            --]]
        end
    end
end

function data.loadFont(path, name)
    data.fonts[name .. "10"] = love.graphics.newFont(path, 10)
    data.fonts[name .. "14"] = love.graphics.newFont(path, 14)
    data.fonts[name .. "18"] = love.graphics.newFont(path, 18)
    data.fonts[name .. "24"] = love.graphics.newFont(path, 24)
end

function data.loadImage(path, name)
    data.images[name] = love.graphics.newImage(path)
end

function data.loadSound(path, name)
    local type = "static"
    if path:sub(-3) == "ogg" then
        type = "stream"
    end
    
    data.sounds[name] = love.audio.newSource(path, type)
end

function data.loadCompanies()
    local file = "Data/company.dat"
    
    for line in io.lines(file) do
        if line ~= "" then
            table.insert(data.company, line)
        end
    end
    
    print("Company data loaded: " .. #data.company .. " total companies")
end

return data
