File = class("File")

function File:initialize()
    self.name = lume.randomchoice(ht.data.filename) .. " " .. self:getID()
    self.size = math.random(1, 4)
    self.value = 0
    self.objective = false
    
    if math.random(1, 4) == 1 then
        value = 5 * math.random(1, 20)
    end
end

function File:getID()
    local hex = { "A", "B", "C", "D", "E", "F" }
    local id = ""
    
    for i = 1, 8 do
        if math.random(1, 2) == 1 then
            id = id .. lume.randomchoice(hex)
        else
            id = id .. tostring(math.random(0, 9))
        end
    end
    
    return id
end
