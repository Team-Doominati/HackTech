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

function Mission:calculatePayment()
    local base = self.level * 100
    local bonus = lume.round(base * (math.random(0, ht.player.stats.negotiation) / 100))
    
    return base + bonus
end

function Mission.generate(level)
    local amount = math.random(10, 20)
    
    ht.missions = {}
    
    for i = 1, amount do
        local mission = Mission:new(lume.randomchoice(ht.data.mission), level)
        
        table.insert(ht.missions, mission)
    end
    
    dgl.console.print("Generated " .. amount .. " missions", "info")
end
