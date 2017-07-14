Mission = class("Mission")

function Mission:initialize(type, level)
    self.type = type
    self.description = type.description
    self.company = lume.randomchoice(ht.data.company)
    self.level = level or 1
    self.payment = self:calculatePayment()
    self.accepted = false
    
    self.accepted = false
end

function Mission:createSystem()
    local nodes = 5 + self.level
    local DS = 1
    local IOP = 1
    
    if self.type == "steal" or self.type == "erase" or self.type == "stealErase" then
        DS = DS + math.random(1, 2)
    end
    
    ht.system.create(self.level, nodes, DS, IOP)
end

function Mission:createObjective()
    if self.type == "steal" or self.type == "erase" or self.type == "stealErase" then
        local datastores = ht.system.getNodes("DS")
        local files = {}
        
        for i, datastore in ipairs(datastores) do
            for j, file in ipairs(datastore.files) do
                table.insert(files, file)
            end
        end
        
        lume.randomchoice(files).objective = true
    end
end

function Mission:calculatePayment()
    local base = self.level * 100
    local bonus = lume.round(base * (math.random(0, ht.player.stats.negotiation) / 100))
    
    return base + bonus
end

function Mission.generate(level)
    local amount = math.random(10, 20)
    
    ht.missions = {}
    
    for i = 1, amount do
        local mission = Mission:new(ht.data.mission[1], level)
        
        table.insert(ht.missions, mission)
    end
    
    print("Generated " .. amount .. " missions")
end

function Mission.accept(id)
    ht.player.mission = ht.missions[id]
    
    ht.player.mission.accepted = true
    ht.player.mission:createSystem()
    ht.player.mission:createObjective()
    
    table.remove(ht.missions, id)
end

function Mission.abandon()
    ht.system.disconnect()
    ht.player.mission = {}
    gui.toggle(gui.mission, true)
end
