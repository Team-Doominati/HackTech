local gui = {}

gui.player =  require "GUI/Player"
gui.deck =    require "GUI/Deck"
gui.mission = require "GUI/Mission"
gui.system =  require "GUI/System"
gui.log =     require "GUI/Log"

function gui.toggle(type)
    type.visible = not type.visible
    
    if type.visible then
        ht.data.sounds.GUIOpen:play()
    else
        ht.data.sounds.GUIClose:play()
    end
end

function gui.setStyle()
    local style =
    {
        Text                  = { 0.90, 0.90, 0.90, 1.00 },
        TextDisabled          = { 0.60, 0.60, 0.60, 1.00 },
        WindowBg              = { 0.00, 0.00, 0.00, 0.70 },
        ChildWindowBg         = { 0.00, 0.00, 0.00, 0.00 },
        PopupBg               = { 0.05, 0.05, 0.10, 0.90 },
        Border                = { 0.70, 0.70, 0.70, 0.65 },
        BorderShadow          = { 0.00, 0.00, 0.00, 0.00 },
        FrameBg               = { 0.80, 0.80, 0.80, 0.30 },
        FrameBgHovered        = { 0.00, 0.80, 0.00, 0.40 },
        FrameBgActive         = { 0.00, 0.65, 0.00, 0.45 },
        TitleBg               = { 0.00, 0.27, 0.00, 0.83 },
        TitleBgCollapsed      = { 0.00, 0.40, 0.00, 0.20 },
        TitleBgActive         = { 0.00, 0.32, 0.00, 0.87 },
        MenuBarBg             = { 0.00, 0.40, 0.00, 0.80 },
        ScrollbarBg           = { 0.00, 0.25, 0.00, 0.60 },
        ScrollbarGrab         = { 0.00, 0.40, 0.00, 0.30 },
        ScrollbarGrabHovered  = { 0.00, 0.40, 0.00, 0.40 },
        ScrollbarGrabActive   = { 0.00, 0.75, 0.00, 0.40 },
        ComboBg               = { 0.20, 0.20, 0.20, 0.99 },
        CheckMark             = { 0.90, 0.90, 0.90, 0.50 },
        SliderGrab            = { 1.00, 1.00, 1.00, 0.30 },
        SliderGrabActive      = { 0.00, 0.75, 0.00, 1.00 },
        Button                = { 0.00, 0.40, 0.00, 0.60 },
        ButtonHovered         = { 0.00, 0.40, 0.00, 1.00 },
        ButtonActive          = { 0.00, 0.50, 0.00, 1.00 },
        Header                = { 0.00, 0.40, 0.00, 0.45 },
        HeaderHovered         = { 0.00, 0.45, 0.00, 0.80 },
        HeaderActive          = { 0.00, 0.53, 0.00, 0.80 },
        Column                = { 0.50, 0.50, 0.50, 1.00 },
        ColumnHovered         = { 0.00, 0.60, 0.00, 1.00 },
        ColumnActive          = { 0.00, 0.70, 0.00, 1.00 },
        ResizeGrip            = { 1.00, 1.00, 1.00, 0.30 },
        ResizeGripHovered     = { 1.00, 1.00, 1.00, 0.60 },
        ResizeGripActive      = { 1.00, 1.00, 1.00, 0.90 },
        CloseButton           = { 0.00, 0.50, 0.00, 0.50 },
        CloseButtonHovered    = { 0.00, 0.66, 0.00, 0.60 },
        CloseButtonActive     = { 0.70, 0.70, 0.70, 1.00 },
        PlotLines             = { 1.00, 1.00, 1.00, 1.00 },
        PlotLinesHovered      = { 0.00, 0.63, 0.00, 1.00 },
        PlotHistogram         = { 0.00, 0.50, 0.00, 1.00 },
        PlotHistogramHovered  = { 1.00, 0.60, 0.00, 1.00 },
        TextSelectedBg        = { 0.00, 0.00, 1.00, 0.35 },
        ModalWindowDarkening  = { 0.20, 0.20, 0.20, 0.35 }
    }
    
    for k, color in pairs(style) do
        imgui.PushStyleColor(k, color[1], color[2], color[3], color[4])
    end
end

return gui
