Mission = class("Mission")

function Mission:initialize(type, level)
    self.type = type
    self.description = type.description
    self.company = lume.randomchoice(ht.data.company)
    self.level = level or 1
    self.payment = 0
    self.accepted = false
    
    self:calculatePayment()
    
    self.accepted = false
end

function Mission:calculatePayment()
end

function Mission.generate(level)
    local amount = math.random(10, 20)
    
    for i = 1, amount do
        local mission = Mission:new(lume.randomchoice(ht.data.mission), level)
        
        table.insert(ht.missions, mission)
    end
    
    dgl.console.print("Generated " .. amount .. " missions", "info")
end
