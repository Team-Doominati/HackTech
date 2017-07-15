ICE = class("ICE")

function ICE:initialize()
    self.x = 0
    self.y = 0
    
    self.name = ""
    self.type = ""
    self.state = "idle"
    
    self.level = 1
    self.integrity = 100
    self.shield = 0
    
    self.stats =
    {
        spot = 0,
        analyze = 0,
        deceive = 0
    }
    
    self.node = nil
    self.selected = false
    self.analyzed = false
    
    self.image = ht.data.images.ICE
    
    self.name = self:getID()
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
    
    self:updateStats()
end

-- TODO: I can probably condense this heavily using table magic, but I just want to see things working for now
function ICE:updateStats()
    local function calculateSpot()
        local chance = 20 + (self.level * 5)
        local stat = ht.player.stats.stealth * 5
        local software = ht.deck.software.camo
        
        chance = chance - stat
        
        if software.loaded then
            chance = chance - software.level * 5
        end
        
        if ht.system.alert ~= "none" then
            chance = chance + 50
        end
        
        if chance < 0 then
            chance = 0
        elseif chance > 100 then
            chance = 100
        end
        
        self.stats.spot = chance
    end

    local function calculateAnalyze()
        local chance = 75 - (self.level * 5)
        local stat = ht.player.stats.analysis * 5
        local software = ht.deck.software.analyze
        
        chance = chance + stat * 5
        
        if software.loaded then
            chance = chance + software.level * 5
        end
        
        if chance < 0 then
            chance = 0
        elseif chance > 100 then
            chance = 100
        end
        
        self.stats.analyze = chance
    end
    
    local function calculateDeceive()
        local chance = 75 - (self.level * 5)
        local stat = ht.player.stats.stealth * 5
        local software = ht.deck.software.deceive
        
        chance = chance + stat * 5
        
        if software.loaded then
            chance = chance + software.level * 5
        end
        
        if chance < 0 then
            chance = 0
        elseif chance > 100 then
            chance = 100
        end
        
        self.stats.deceive = chance
    end
    
    calculateSpot()
    calculateAnalyze()
    calculateDeceive()
end

function ICE:turn()
    if self.state == "idle" then
        if math.random(1, 100) <= self.stats.spot then
            self.state = "spot"
            gui.log.add("ICE " .. self.name .. " is querying you", "warning")
            ht.data.sounds.ICESpotCheck:play()
        end
    elseif self.state == "spot" then
        if math.random(1, 2) == 1 then
            ht.system.setAlert()
            
            if ht.system.alert == "passive" then
                gui.log.add("ICE " .. self.name .. " has raised the alert level", "yellow")
                ht.data.sounds.ICESpotPassive:play()
            elseif ht.system.alert == "active" then
                gui.log.add("ICE " .. self.name .. " has raised the alert level", "red")
                ht.data.sounds.ICEAlert:play()
                self.state = "attack"
            end
        end
    elseif self.state == "attack" then
        local damage = self.level * 5 - ht.deck.integrity.armor
        
        gui.log.add("ICE " .. self.name .. " attacked you for " .. damage .. " damage", "yellow")
        ht.data.sounds.ICEAttack:play()
        
        ht.deck.damage(damage)
        
        if not ht.system.alert == "active" then
            ht.system.setAlert("active")
        end
    end
end

function ICE:damage(amount)
    self.integrity = self.integrity - amount
    
    if self.integrity <= 0 then
        self:destroy()
    end
end

function ICE:destroy()
    gui.log.add("ICE " .. self.name .. " was destroyed", "info")
    ht.data.sounds.ICEDestroy:play()
    
    if ht.system.target == self then
        ht.system.target = nil
    end
end

function ICE:getID()
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

function ICE:isAttacking()
    return self.state == "attack"
end

function ICE:isClear()
    return self.state == "clear"
end
