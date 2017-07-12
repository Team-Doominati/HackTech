require "imgui"

require "Lib/Class"
require "Lib/Sandbox"

flux = require "Lib/Flux"
lume = require "Lib/Lume"

dgl =  require "DGL/DGL"
ht  =  require "HackTech/HackTech"
gui =  require "GUI/GUI"

timer = 0

print("HackTech initialized!");

math.randomseed(os.time())

function love.load()
end

function love.quit()
    imgui.ShutDown();
end

function love.draw()
    love.graphics.setBackgroundColor(0, 16, 0, 0)
    
    local width, height = love.graphics.getDimensions()
    love.graphics.scale(width / dgl.drawing.width, height / dgl.drawing.height)
    
    dgl.console.update()
    gui.player.update()
    gui.deck.update()
    
    imgui.Render();
end

function love.update(dt)
    imgui.NewFrame()
    flux.update(dt)
    
    ht.deck.update()
    
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
    
    if key == "\\" then
        dgl.music.playRandomSong("Data/Music")
    end
    
    if key == "f1" then
        gui.toggle(gui.player)
    end
    
    if key == "f2" then
        gui.toggle(gui.deck)
    end
    
    if not imgui.GetWantCaptureKeyboard() then
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

function love.mousemoved(x, y)
    imgui.MouseMoved(x, y)
    
    if not imgui.GetWantCaptureMouse() then
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    
    if not imgui.GetWantCaptureMouse() then
    end
end

function love.textinput(text)
    imgui.TextInput(text)
    
    if not imgui.GetWantCaptureKeyboard() then
    end
end
