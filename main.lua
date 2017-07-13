require "imgui"

require "Lib/Sandbox"

class = require "Lib/Class"
flux =  require "Lib/Flux"
lume =  require "Lib/Lume"

dgl =   require "DGL/DGL"
ht  =   require "HackTech/HackTech"
gui =   require "GUI/GUI"

timer = 0
camera =
{
    x = 0,
    y = 0,
    sx = 1,
    sy = 1
}

print("HackTech initialized!");

math.randomseed(os.time())

function love.load()
    ht.data.loadCompanies()
    
    ht.generateMissions(1)
end

function love.quit()
    imgui.ShutDown();
end

function love.draw()
    love.graphics.push()
    
    local width, height = love.graphics.getDimensions()
    love.graphics.scale(width / dgl.drawing.width, height / dgl.drawing.height)
    love.graphics.scale(camera.sx, camera.sy)
    love.graphics.translate(camera.x, camera.y)
    
    dgl.console.update()
    gui.player.update()
    gui.deck.update()
    gui.mission.update()
    
    ht.system.draw()
    
    love.graphics.pop()
    
    imgui.Render();
end

function love.update(dt)
    imgui.NewFrame()
    flux.update(dt)
    
    ht.deck.update()
    ht.system.update(dt)
    
    timer = timer + dt
end

function love.keypressed(key, isRepeat)
    imgui.KeyPressed(key)
    
    if key == "escape" then
        love.event.quit()
    end
    
    if key == "`" then
        gui.toggle(dgl.console)
    end
    
    if key == "f1" then
        gui.toggle(gui.player)
    end
    
    if key == "f2" then
        gui.toggle(gui.deck)
    end
    
    if key == "f3" then
        gui.toggle(gui.mission)
    end
    
    if key == "f6" then
        ht.system.create()
        ht.system.connected = true
    end
    
    if key == "f7" then
        dgl.music.playRandomSong("Data/Music")
    end
    
    if not imgui.GetWantCaptureKeyboard() then
        ht.system.keypressed(key)
    end
end

function love.keyreleased(key)
    imgui.KeyReleased(key)
    
    if not imgui.GetWantCaptureKeyboard() then
    end
end

function love.mousepressed(x, y, button, isTouch)
    imgui.MousePressed(button)
    
    if not imgui.GetWantCaptureMouse() then
    end
end

function love.mousereleased(x, y, button, isTouch)
    imgui.MouseReleased(button)
    
    if not imgui.GetWantCaptureMouse() then
    end
end

function love.mousemoved(x, y, dx, dy, isTouch)
    imgui.MouseMoved(x, y)
    
    if not imgui.GetWantCaptureMouse() then
        if love.mouse.isDown(2) then
            camera.x = camera.x + dx
            camera.y = camera.y + dy
        end
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    
    if not imgui.GetWantCaptureMouse() then
        camera.sx = camera.sx + (y * 0.25)
        camera.sy = camera.sy + (y * 0.25)
        
        if camera.sx <= 0.25 then
            camera.sx = 0.25
        end
        if camera.sx > 2 then
            camera.sx = 2
        end
        if camera.sy <= 0.25 then
            camera.sy = 0.25
        end
        if camera.sy > 2 then
            camera.sy = 2
        end
    end
end

function love.textinput(text)
    imgui.TextInput(text)
    
    if not imgui.GetWantCaptureKeyboard() then
    end
end
