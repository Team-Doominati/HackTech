local math = {}

function math.pulse(max, speed, offset)
    max = max or 127
    speed = speed or 1
    offset = offset or 0
    
    return _G.math.abs(_G.math.sin((os.clock() * speed) + offset) * max)
end

function math.percent(value, max)
    return (value / max) * 100
end

return math
