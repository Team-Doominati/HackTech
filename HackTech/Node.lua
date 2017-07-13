Node = class("Node")

function Node:initialize()
    self.x = 0
    self.y = 0
    self.type = "none"
    self.security = "none"
    self.ICE = {}
    self.cleared = false
    self.activated = false
    self.objective = false
    self.prev = nil
    self.next = nil
end

function Node:draw()
    local size = 0
    local securityColor = {}
    local nodeColor = {}
    
    if self.security == "none" then
        securityColor = dgl.color.white
    elseif self.security == "low" then
        securityColor = dgl.color.green
    elseif self.security == "medium" then
        securityColor = dgl.color.yellow
    elseif self.security == "high" then
        securityColor = dgl.color.orange
    elseif self.security == "max" then
        securityColor = dgl.color.red
    end
    
    if self.type == "AP" then
        size = 64
        nodeColor = dgl.color.purple
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", self.x, self.y, size)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.circle("fill", self.x, self.y, size)
    elseif self.type == "J" then
        size = 32
        nodeColor = dgl.color.cyan
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", self.x, self.y, size)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.circle("fill", self.x, self.y, size)
    elseif self.type == "DS" then
        size = 64
        nodeColor = dgl.color.green
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.rectangle("line", self.x - size / 2, self.y - size / 2, size, size)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.rectangle("fill", self.x - size / 2, self.y - size / 2, size, size)
    elseif self.type == "IOP" then
        size = 48
        nodeColor = dgl.color.yellow
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", self.x, self.y, size, 3)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.circle("fill", self.x, self.y, size, 3)
    elseif self.type == "SM" then
        size = 48
        nodeColor = dgl.color.orange
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", self.x, self.y, size, 4)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.circle("fill", self.x, self.y, size, 4)
    elseif self.type == "CPU" then
        size = 56
        nodeColor = dgl.color.red
        
        love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", self.x, self.y, size, 8)
        love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
        love.graphics.circle("fill", self.x, self.y, size, 8)
    end
end

function Node:update()
    if #self.ICE == 0 then -- Temporary check, later it should iterate ICE and check if they are clear as well
        self.cleared = true
    end
end
