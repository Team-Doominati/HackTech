Software = class("Software")

function Software:initialize(type, level)
    self.type = type
    self.level = level or 0
    
    self.loaded = false
    self.active = false
end

function Software:run(target)
    target = target or nil
end

function Software:getSize()
    return self.level
end
