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

function system.create(level)
    level = level or 1
    
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
        local node = {}
        
        node.x = x
        node.y = y
        node.type = type
        node.security = "white"
        node.ICE = {}
        node.cleared = false
        node.activated = false
        node.objective = false
        node.prev = nil
        node.next = nil
        
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
        local current, max = 0, 10
        
        while current < max do
            createNode("J")
            current = current + 1
        end
    end
    
    local function placeDS()
        local current, max = 0, 2
        
        while current < max do
            local node = math.random(2, #system.nodes - 1)
            
            if system.nodes[node].type == "J" then
                system.nodes[node].type = "DS"
                
                current = current + 1
            end
        end
    end
    
    local function placeIOP()
        local current, max = 0, 2
        
        while current < max do
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

function system.move(type)
    if type == "forward" and system.currentNode < #system.nodes - 1 and system.getCurrentNode().cleared then
        system.currentNode = system.currentNode + 1
        
        if system.currentNode > system.cleared then
            system.cleared = system.currentNode
        end
        
        system.sounds.move:play()
        system.turn = system.turn + 1
    elseif type == "back" and system.currentNode > 1 then
        system.currentNode = system.currentNode - 1
        
        system.sounds.move:play()
        system.turn = system.turn + 1
    end
end

function system.getCurrentNode()
    return system.nodes[system.currentNode]
end

function system.draw()
    if not system.connected then return end
    
    love.graphics.setBackgroundColor(0, 16, 0)
    
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
        local size = 0
        local securityColor = {}
        local nodeColor = {}
        
        if node.security == "white" then
            securityColor = dgl.color.white
        elseif node.security == "green" then
            securityColor = dgl.color.green
        elseif node.security == "yellow" then
            securityColor = dgl.color.yellow
        elseif node.security == "orange" then
            securityColor = dgl.color.orange
        elseif node.security == "red" then
            securityColor = dgl.color.red
        end
        
        if node.type == "AP" then
            size = 64
            nodeColor = dgl.color.purple
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.circle("line", node.x, node.y, size)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.circle("fill", node.x, node.y, size)
        elseif node.type == "J" then
            size = 32
            nodeColor = dgl.color.cyan
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.circle("line", node.x, node.y, size)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.circle("fill", node.x, node.y, size)
        elseif node.type == "DS" then
            size = 64
            nodeColor = dgl.color.green
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.rectangle("line", node.x - size / 2, node.y - size / 2, size, size)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.rectangle("fill", node.x - size / 2, node.y - size / 2, size, size)
        elseif node.type == "IOP" then
            size = 48
            nodeColor = dgl.color.yellow
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.circle("line", node.x, node.y, size, 3)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.circle("fill", node.x, node.y, size, 3)
        elseif node.type == "SM" then
            size = 48
            nodeColor = dgl.color.orange
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.circle("line", node.x, node.y, size, 4)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.circle("fill", node.x, node.y, size, 4)
        elseif node.type == "CPU" then
            size = 56
            nodeColor = dgl.color.red
            
            love.graphics.setColor(securityColor[1], securityColor[2], securityColor[3], 128)
            love.graphics.setLineWidth(4)
            love.graphics.circle("line", node.x, node.y, size, 8)
            love.graphics.setColor(nodeColor[1], nodeColor[2], nodeColor[3], 64)
            love.graphics.circle("fill", node.x, node.y, size, 8)
        end
    end
    
    love.graphics.setColor(unpack(dgl.color.white))
    love.graphics.setLineWidth(1)
end

function system.update()
    if not system.connected then return end
    
    for i, node in pairs(system.nodes) do
        if #node.ICE == 0 then -- Temporary check, later it should iterate ICE and check if they are clear as well
            node.cleared = true
        end
    end
end

function system.keypressed(key)
    if not system.connected then return end
    
    if key == "space" then
        system.move("forward")
    end
    if key == "c" then
        system.move("back")
    end
end

function system.clear()
    system.nodes = {}
    system.currentNode = 1
    system.cleared = 0
    system.turn = 1
    system.target = nil
    
    system.setAlert("none")
end

function system.setAlert(level)
    system.alert = level
    
    if system.alert == "none" then
    elseif system.alert == "passive" then
    elseif system.alert == "active" then
    elseif system.alert == "shutdown" then
    end
end

return system
