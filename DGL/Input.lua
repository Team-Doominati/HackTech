local input = {}

function input.pick(x, y, offset, size)
    offset = offset or 0
    size = size or 32
    
    local x2, y2 = drawing.getScale(love.mouse.getPosition())
    
    return x2 >= x - offset / 2 and x2 <= x - offset / 2 + size and
           y2 >= y - offset / 2 and y2 <= y - offset / 2 + size
end

return input
