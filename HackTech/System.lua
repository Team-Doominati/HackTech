local system =
{
    connected = false,
    
    level = 1,
    
    nodes = {},
    
    alert = "none",
    
    currentNode = 1,
    cleared = 0,
    turn = 1,
    timer = 0,
    
    target = nil,
    
    nodeOffset = 512
}

function system.create(level, maxNodes, maxDS, maxIOP)
    level = level or 1
    maxNodes = maxNodes or 10
    maxDS = maxDS or 1
    maxIOP = maxIOP or 1
    
    local x, y, id = dgl.drawing.width / 2, dgl.drawing.height / 2, 1
    
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
        
        node.id = id
        node.x = x
        node.y = y
        node.name = type .. "-" .. node.id
        node.type = type
        node.security = "none"
        
        if #system.nodes > 0 then
            node.prev = system.nodes[#system.nodes]
            system.nodes[#system.nodes].next = node
        end
        
        move()
        
        id = id + 1
        
        table.insert(system.nodes, node)
    end
    
    local function modifyNode(node, type, security)
        security = security or "none"
        
        node.name = type .. "-" .. node.id
        node.type = type
        node.security = security
        
        if type == "DS" then
            node:generateFiles()
        end
    end
    
    local function placeAP()
        createNode("AP")
    end
    
    local function placeJ()
        local current = 0
        
        while current < maxNodes do
            createNode("J")
            current = current + 1
        end
    end
    
    local function placeDS()
        local current = 0
        
        while current < maxDS do
            local node = system.nodes[math.random(2, #system.nodes - 1)]
            
            if node.type == "J" then
                modifyNode(node, "DS")
                
                current = current + 1
            end
        end
    end
    
    local function placeIOP()
        local current = 0
        
        while current < maxIOP do
            local node = system.nodes[math.random(2, #system.nodes - 1)]
            
            if node.type == "J" then
                modifyNode(node, "IOP")
                
                current = current + 1
            end
        end
    end
    
    local function placeSM()
        local placed = false
        
        while not placed do
            local node = system.nodes[math.random(2, #system.nodes - 1)]
            
            if node.type == "J" then
                modifyNode(node, "SM")
                placed = true
            end
        end
    end
    
    local function placeCPU()
        modifyNode(system.nodes[#system.nodes], "CPU")
    end
    
    local function placeICE()
        for i, node in ipairs(system.nodes) do
            node:generateICE()
        end
    end
    
    system.clear()
    
    system.level = level
    
    placeAP()
    placeJ()
    placeDS()
    placeIOP()
    placeSM()
    placeCPU()
    placeICE()
    
    system.nodes[1]:center()
    
    for i, node in pairs(system.nodes) do
        gui.log.add("Node " .. node.name .. " found", "info")
    end
    
    print("Generated level " .. level .. " system with " .. #system.nodes .. " nodes")
end

function system.draw()
    if not system.connected then return end
    
    if system.alert == "none" then
        love.graphics.setBackgroundColor(0, 32, 0)
    elseif system.alert == "passive" then
        love.graphics.setBackgroundColor(32 + (math.sin(timer) * 8), 32 + (math.sin(timer) * 8), 0)
    elseif system.alert == "active" then
        love.graphics.setBackgroundColor(32 + (math.sin(timer * 4) * 8), 0, 0)
    end
    
    for i, node in pairs(system.nodes) do
        if node.next ~= nil then
            if i == system.currentNode and system.getCurrentNode().cleared then
                love.graphics.setLineWidth(3 + (math.sin(timer * 4) * 2))
                love.graphics.setColor(unpack(dgl.color.yellow))
            elseif i < system.cleared then
                love.graphics.setLineWidth(3)
                love.graphics.setColor(unpack(dgl.color.green))
            else
                love.graphics.setColor(unpack(dgl.color.white))
            end
            
            love.graphics.line(node.x, node.y, node.next.x, node.next.y)
            
            love.graphics.setLineWidth(1)
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
    
    if system.isWaiting() then
        coroutine.resume(system.doTurn)
        system.timer = system.timer - dt
    end
end

function system.keypressed(key)
    if not system.connected then return end
    
    if key == "lctrl" then
        system.getCurrentNode():center()
    end
    
    if not system.isWaiting() then
        if key == "space" then
            system.move()
        end
        
        if key == "w" then
            system.waitTurn()
        end
        
        if key == "v" then
            if ht.deck.software.analyze:run() then
                system.startTurn()
            end
        end
        
        if key == "d" then
            if ht.deck.software.deceive:run() then
                system.startTurn()
            end
        end
        
        if key == "1" then
            if ht.deck.software.attack:run() then
                system.startTurn()
            end
        end
    end
end

function system.getNodes(type)
    local nodes = {}
    
    for i, node in ipairs(system.nodes) do
        if node.type == type then
            table.insert(nodes, node)
        end
    end
    
    return nodes
end

function system.getCurrentNode()
    return system.nodes[system.currentNode]
end

function system.isWaiting()
    if system.doTurn == nil then
        return false
    else
        return coroutine.status(system.doTurn) ~= "dead"
    end
end

function system.addWait(time)
    system.timer = system.timer + time
end

function system.setAlert(level)
    level = level or nil
    
    if level == nil then
        if system.alert == "none" then
            system.alert = "passive"
        elseif system.alert == "passive" then
            system.alert = "active"
        end
    else
        system.alert = level
    end
    
    system.doAlert()
end

function system.doAlert()
    if system.alert == "none" then
        if ht.data.sounds.systemAlertLoop:isPlaying() then
            ht.data.sounds.systemAlertStop:play()
            ht.data.sounds.systemAlertLoop:stop()
        end
    elseif system.alert == "passive" then
        for i, node in ipairs(system.nodes) do
            if node ~= system.getCurrentNode() then
                for j, ICE in ipairs(node.ICE) do
                    ICE.state = "idle"
                end
            end
        end
    elseif system.alert == "active" then
        if not ht.data.sounds.systemAlertLoop:isPlaying() then
            ht.data.sounds.systemAlertLoop:play()
        end
        
        for i, node in ipairs(system.nodes) do
            for j, ICE in ipairs(node.ICE) do
                ICE.state = "attack"
            end
        end
    end
end

function system.startTurn()
    system.doTurn = coroutine.create(system._doTurn)
    
    coroutine.resume(system.doTurn)
end

function system._doTurn()
    --[[
          TODO: Turn order logic
        - Turn increment
        - Node/ICE-affecting program expiration check (silence, virus, etc)
        - Player program run/continue (scan, crackers, etc)
        - File transfer progress (download, etc)
        - ICE spot check (if not alerted)
        - ICE attack (if alerted)
        - Player action
    --]]
    
    local node = system.getCurrentNode()
    
    system.turn = system.turn + 1
    
    system.timer = 0.5
    while system.timer > 0 do
        coroutine.yield()
    end
    
    for i, ICE in ipairs(node.ICE) do
        ICE:turn()
        
        system.timer = system.timer + 0.5
        while system.timer > 0 do
            coroutine.yield()
        end
    end
end

function system.move()
    if system.currentNode < #system.nodes and system.getCurrentNode().cleared then
        system.currentNode = system.currentNode + 1
        
        if system.currentNode > system.cleared then
            system.cleared = system.currentNode
        end
        
        system.getCurrentNode():center()
        ht.data.sounds.systemMove:play()
        
        system.startTurn()
    end
end

function system.waitTurn()
    gui.log.add("You waited", "info")
    
    system.startTurn()
end

function system.connect()
    system.connected = true
    
    system.nodes[1]:center()
    
    gui.target.visible = true
    
    gui.log.add("You connected to the system", "info")
    ht.data.sounds.systemConnect:play()
    
    system.doAlert()
end

function system.disconnect()
    system.connected = false
    
    system.currentNode = 1
    system.turn = 1
    system.target = nil
    
    gui.target.visible = false
    
    gui.log.add("You disconnected from the system", "info")
    ht.data.sounds.systemDisconnect:play()
    
    if ht.data.sounds.systemAlertLoop:isPlaying() then
        ht.data.sounds.systemAlertStop:play()
        ht.data.sounds.systemAlertLoop:stop()
    end
end

function system.clear()
    for i, node in pairs(system.nodes) do
        node:initialize()
    end
    
    system.nodes = {}
    
    system.currentNode = 1
    system.cleared = 0
    system.turn = 1
    
    system.setAlert("none")
end

return system
