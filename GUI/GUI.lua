local gui = {}

gui.player = require "GUI/Player"
gui.deck =   require "GUI/Deck"

gui.sounds =
{
    open = love.audio.newSource("Data/Sound/GUIOpen.wav", "static"),
    close = love.audio.newSource("Data/Sound/GUIClose.wav", "static")
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
