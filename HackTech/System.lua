local system =
{
    connected = false,
    
    level = 1,
    
    nodes = {},
    
    alert = "none",
    
    currentNode = 1,
    cleared = 0,
    turn = 1,
    
    target = nil,
    
    nodeOffset = 128,
    
    sounds =
    {
        move = love.audio.newSource("Data/Sound/Move.wav", "static")
    }
}

function system.create(level, maxJ, maxDS, maxIOP)
    level = level or 1
    maxJ = maxJ or 10
    maxDS = maxDS or 2
    maxIOP = maxIOP or 2
    
    local x, y = dgl.drawing.width / 2, dgl.drawing.height / 2
    
    local function move()
        local newX, newY = 0, 0
        local success = false
        local mult = 1
        
        while not success do
            local dir = math.random(1, 4) -- Not using the diagonals for now
            
            success = true
            
            if dir == 1 then
                newY = y + system.nodeOffset * mult
            elseif dir == 2 then
                newY = y - system.nodeOffset * mult
            elseif dir == 3 then
                newX = x - system.nodeOffset * mult
            elseif dir == 4 then
                newX = x + system.nodeOffset * mult
            elseif dir == 5 then
                newX = x - system.nodeOffset * mult
                newY = y + system.nodeOffset * mult
            elseif dir == 6 then
                newX = x + system.nodeOffset * mult
                newY = y + system.nodeOffset * mult
            elseif dir == 7 then
                newX = x - system.nodeOffset * mult
                newY = y - system.nodeOffset * mult
            elseif dir == 8 then
                newX = x + system.nodeOffset * mult
                newY = y - system.nodeOffset * mult
            end
            
            for i, node in pairs(system.nodes) do
                if newX >= node.x - system.nodeOffset and
                   newX <= node.x + system.nodeOffset and
                   newY >= node.y - system.nodeOffset and
                   newY <= node.y + system.nodeOffset then
                    success = false
                    
                    if math.random(1, 100) == 1 then
                        mult = mult + 1
                    end
                end
            end
        end
        
        x = newX
        y = newY
    end
    
    local function createNode(type)
        local node = Node:new()
        
        node.x = x
        node.y = y
        node.type = type
        node.security = "none"
        
        if #system.nodes > 0 then
            node.prev = system.nodes[#system.nodes]
            system.nodes[#system.nodes].next = node
        end
        
        move()
        
        table.insert(system.nodes, node)
    end
    
    local function placeAP()
        createNode("AP")
    end
    
    local function placeJ()
        local current = 0
        
        while current < maxJ do
            createNode("J")
            current = current + 1
        end
    end
    
    local function placeDS()
        local current = 0
        
        while current < maxDS do
            local node = math.random(2, #system.nodes - 1)
            
            if system.nodes[node].type == "J" then
                system.nodes[node].type = "DS"
                
                current = current + 1
            end
        end
    end
    
    local function placeIOP()
        local current = 0
        
        while current < maxIOP do
            local node = math.random(2, #system.nodes - 1)
            
            if system.nodes[node].type == "J" then
                system.nodes[node].type = "IOP"
                
                current = current + 1
            end
        end
    end
    
    local function placeSM()
        local placed = false
        
        while not placed do
            local SM = math.random(2, #system.nodes - 1)
            
            if system.nodes[SM].type == "J" then
                system.nodes[SM].type = "SM"
                placed = true
            end
        end
    end
    
    local function placeCPU()
        system.nodes[#system.nodes].type = "CPU"
    end
    
    system.clear()
    
    placeAP()
    placeJ()
    placeDS()
    placeIOP()
    placeSM()
    placeCPU()
    
    print("Generated level " .. level .. " system with " .. #system.nodes .. " nodes")
end

function system.draw()
    if not system.connected then return end
    
    love.graphics.setBackgroundColor(dgl.color.darkGreen)
    
    for i, node in pairs(system.nodes) do
        if node.next ~= nil then
            if i == system.currentNode and system.getCurrentNode().cleared then
                love.graphics.setColor(unpack(dgl.color.yellow))
            elseif i <= system.cleared then
                love.graphics.setColor(unpack(dgl.color.green))
            else
                love.graphics.setColor(unpack(dgl.color.white))
            end
            
            love.graphics.line(node.x, node.y, node.next.x, node.next.y)
        end
    end
    
    for i, node in pairs(system.nodes) do
        node:draw()
    end
    
    love.graphics.setColor(unpack(dgl.color.white))
    love.graphics.setLineWidth(1)
end

function system.update(dt)
    if not system.connected then return end
    
    for i, node in pairs(system.nodes) do
        node:update()
    end
end

function system.keypressed(key)
    if not system.connected then return end
    
    if key == "space" then
        system.move()
    end
end

function system.move()
    if system.currentNode < #system.nodes - 1 and system.getCurrentNode().cleared then
        system.currentNode = system.currentNode + 1
        
        if system.currentNode > system.cleared then
            system.cleared = system.currentNode
        end
        
        system.sounds.move:play()
        system.turn = system.turn + 1
    end
end

function system.getCurrentNode()
    return system.nodes[system.currentNode]
end

function system.setAlert(level)
    system.alert = level
    
    if system.alert == "none" then
    elseif system.alert == "passive" then
    elseif system.alert == "active" then
    elseif system.alert == "shutdown" then
    end
end

function system.clear()
    for i, node in pairs(system.nodes) do
        node:initialize()
    end
    
    system.nodes = {}
    
    system.setAlert("none")
end

return system
