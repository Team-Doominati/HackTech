local gui = {}

gui.player =  require "GUI/Player"
gui.deck =    require "GUI/Deck"
gui.mission = require "GUI/Mission"
gui.system =  require "GUI/System"
gui.log =     require "GUI/Log"

function gui.toggle(type, noSound)
    noSound = noSound or false
    
    type.visible = not type.visible
    
    if not noSound then
        if type.visible then
            ht.data.sounds.GUIOpen:play()
        else
            ht.data.sounds.GUIClose:play()
        end
    end
end

return gui
