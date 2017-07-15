require "imgui"

require "Lib/Sandbox"

class  = require "Lib/Class"
camera = require "Lib/Camera"
flux =   require "Lib/Flux"
lume =   require "Lib/Lume"

dgl =    require "DGL/DGL"
ht  =    require "HackTech/HackTech"
gui =    require "GUI/GUI"

timer = 0
cam = camera(dgl.drawing.width / 2, dgl.drawing.height / 2)

math.randomseed(os.time())

function love.load()
    gui.setStyle()
    ht.data.load()
    ht.deck.initialize()
    Mission.generate(1)
end

function love.quit()
    imgui.ShutDown();
end

function love.draw()
    love.graphics.setBackgroundColor(unpack(dgl.color.black))
    
    local width, height = love.graphics.getDimensions()
    love.graphics.scale(width / dgl.drawing.width, height / dgl.drawing.height)
    love.graphics.scale(camera.sx, camera.sy)
    
    gui.player.update()
    gui.deck.update()
    gui.mission.update()
    gui.system.update()
    gui.target.update()
    gui.log.update()
    
    cam:attach()
    ht.system.draw()
    cam:detach()
    
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
    
    if key == "f1" then
        gui.toggle(gui.player)
    end
    
    if key == "f2" then
        gui.toggle(gui.deck)
    end
    
    if key == "f3" and ht.player.mission ~= nil and not ht.player.mission.accepted then
        gui.toggle(gui.mission)
    end
    
    if key == "f4" then
        gui.toggle(gui.system)
    end
    
    if key == "f5" and ht.system.connected then
        gui.toggle(gui.target)
    end
    
    if key == "f6" then
        gui.toggle(gui.log)
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
            cam:move(-dx * (2 / cam.scale), -dy * (2 / cam.scale))
        end
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    
    if not imgui.GetWantCaptureMouse() then
        if y == -1 and cam.scale > 0.05 then
            cam:zoom(0.5)
        elseif y == 1 and cam.scale < 1 then
            cam:zoom(2)
        end
    end
end

function love.textinput(text)
    imgui.TextInput(text)
    
    if not imgui.GetWantCaptureKeyboard() then
    end
end

debugger = require "Lib/Debugger" ()
