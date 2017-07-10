-- Libraries
--------------------------------------------------------------------------------

require "imgui"

require "Lib/Class"
require "Lib/Sandbox"

flux = require "Lib/Flux"
lume = require "Lib/Lume"

-- Sub-Modules
--------------------------------------------------------------------------------

dgl = require "DGL/DGL"
gui = require "GUI/GUI"

-- Initialization
--------------------------------------------------------------------------------

print("HackTech initialized!");

-- Seed the RNG
math.randomseed(os.time())

-- Music
-- dgl.music.playRandomSong("Data/Music")

-- Load/Quit
--------------------------------------------------------------------------------

function love.load()
end

function love.quit()
    imgui.ShutDown();
end

-- Drawing
--------------------------------------------------------------------------------

function love.draw()
    love.graphics.setBackgroundColor(0, 16, 0, 0)
    
    local width, height = love.graphics.getDimensions()
    love.graphics.scale(width / dgl.drawing.width, height / dgl.drawing.height)
    
    dgl.console.update()
    
    imgui.Render();
end

-- Updating
--------------------------------------------------------------------------------

function love.update(dt)
    imgui.NewFrame()
    flux.update(dt)
end

-- Input Handling
--------------------------------------------------------------------------------

function love.keypressed(key, isRepeat)
    imgui.KeyPressed(key)
    
    if key == "escape" then
        love.event.quit()
    end
    
    if key == "`" then
        dgl.console.toggle()
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
