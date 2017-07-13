local gui = {}

gui.player =  require "GUI/Player"
gui.deck =    require "GUI/Deck"
gui.mission = require "GUI/Mission"
gui.log =     require "GUI/Log"

function gui.toggle(type)
    type.visible = not type.visible
    
    if type.visible then
        ht.data.sounds.GUIOpen:play()
    else
        ht.data.sounds.GUIClose:play()
    end
end

return gui
