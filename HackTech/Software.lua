Software = class("Software")

function Software:initialize(type, level)
    self.type = type
    self.level = level or 0
    
    self.loaded = false
    self.active = false
end

function Software:run()
    local target = ht.system.target
    
    if target == nil then return false end
    
    if self.type == "analyze" and not target.analyzed then
        if math.random(1, 100) <= target.stats.analyze then
            target.analyzed = true
            gui.log.add("ICE " .. target.name .. " was analyzed successfully", "info")
            ht.data.sounds.softwareAnalyze:play()
        else
            gui.log.add("ICE " .. target.name .. " resisted the analysis attempt", "warning")
            ht.data.sounds.softwareFail:play()
        end
        
        return true
    elseif self.type == "deceive" and not target:isAttacking() and not target:isClear() then
        if math.random(1, 100) <= target.stats.deceive then
            target.state = "clear"
            gui.log.add("ICE " .. target.name .. " was deceived successfully", "info")
            ht.data.sounds.softwareDeceive:play()
        else
            gui.log.add("ICE " .. target.name .. " resisted the deceive attempt", "warning")
            ht.data.sounds.softwareFail:play()
        end
        
        return true
    elseif self.type == "attack" then
        local damage = (self.level + ht.player.stats.attack) * 5
        
        gui.log.add("Attacked ICE " .. target.name .. " for " .. damage .. " damage", "info")
        ht.data.sounds.softwareAttack:play()
        ht.system.setAlert("active")
        
        target:damage(damage)
        
        return true
    else
        return false
    end
end

function Software:getSize()
    return self.level
end
