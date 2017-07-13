local gui = {}

gui.player =  require "GUI/Player"
gui.deck =    require "GUI/Deck"
gui.mission = require "GUI/Mission"

gui.sounds =
{
    open = love.audio.newSource("Data/Sounds/GUIOpen.wav", "static"),
    close = love.audio.newSource("Data/Sounds/GUIClose.wav", "static")
}

function gui.toggle(type)
    type.visible = not type.visible
    
    if type.visible then
        gui.sounds.open:play()
    else
        gui.sounds.close:play()
    end
end

return gui
