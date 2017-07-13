local hacktech = {}

-- Modules
hacktech.data =   require "HackTech/Data"
hacktech.player = require "HackTech/Player"
hacktech.deck =   require "HackTech/Deck"
hacktech.system = require "HackTech/System"

-- Classes
require "Hacktech/Node"

-- Globals
hacktech.day = 1
hacktech.missions = {}

function hacktech.generateMissions(level)
    local types =
    {
        { "steal", "Steal Files" },
        { "erase", "Erase Files" },
        { "stealErase", "Steal and Erase Files" },
        { "activate", "Activate I/O" },
        { "backdoor", "Install Backdoor" },
        { "crash", "Crash System" },
        { "clear", "Clear all ICE" }
    }
    
    local amount = math.random(10, 20)
    
    for i = 1, amount do
        local mission = {}
        local type = types[math.random(1, #types)]
        
        mission.type = type[1]
        mission.description = type[2]
        mission.company = hacktech.data.company[math.random(1, #hacktech.data.company)]
        mission.level = level
        mission.payment = 100 * math.random(1, 5)
        
        table.insert(hacktech.missions, mission)
    end
    
    print("Generated " .. amount .. " missions")
end

return hacktech
