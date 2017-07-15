ICE = class("ICE")

function ICE:initialize()
    self.x = 0
    self.y = 0
    self.name = ""
    self.type = ""
    self.level = 0
    self.integrity = 100
    self.shield = 0
    self.node = nil
    self.selected = false
    self.analyzed = false
    self.alerted = false
    self.image = ht.data.images.ICE
end

function ICE:draw()
    if self.selected then
        love.graphics.setColor(unpack(dgl.color.red))
    else
        love.graphics.setColor(unpack(dgl.color.white))
    end
    
    love.graphics.draw(self.image, self.x, self.y, timer % 360, 1, 1, self.image:getWidth() / 2, self.image:getHeight() / 2)
    
    if ht.system.target == self then
        local targetImage = ht.data.images.target
        
        love.graphics.setColor(unpack(dgl.color.red))
        love.graphics.draw(targetImage, self.x, self.y, timer % 360, 2, 2, targetImage:getWidth() / 2, targetImage:getHeight() / 2)
    end
end

function ICE:update()
    local x, y = cam:worldCoords(love.mouse.getPosition())
    local width, height = self.image:getWidth(), self.image:getHeight()
    
    if not love.mouse.isDown(2) and not imgui.GetWantCaptureMouse() and
       x >= self.x - width / 2 and x <= self.x + width / 2 and
       y >= self.y - height / 2 and y <= self.y + height / 2 then
        if not self.selected then
            ht.data.sounds.ICEHover:play()
        end
        
        self.selected = true
    else
        self.selected = false
    end
    
    if ht.system.target ~= self and ht.system.getCurrentNode() == self.node and not imgui.GetWantCaptureMouse() and
       self.selected and love.mouse.isDown(1) then
        ht.system.target = self
        ht.data.sounds.ICETarget:play()
    end
end

function File:getID()
    local hex = { "A", "B", "C", "D", "E", "F" }
    local id = ""
    
    for i = 1, 4 do
        if math.random(1, 2) == 1 then
            id = id .. lume.randomchoice(hex)
        else
            id = id .. tostring(math.random(0, 9))
        end
    end
    
    return id
end
