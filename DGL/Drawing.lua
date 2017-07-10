local drawing =
{
    width = 1280,
    height = 720
}

function drawing.drawInRect(img, x, y, w, h, r, kx, ky)
    local width = img:getWidth()
    local height = img:getHeight()
    local sx = w / width
    local sy = h / height
    
    love.graphics.draw(img, x, y, r, sx, sy, width / 2, height / 2, kx, ky)
end

function drawing.drawBorderRect(x, y, width, height, colors, roundx, roundy, segments)
    roundx = roundx or 0
    roundy = roundy or 0
    segments = segments or 0
    
    love.graphics.setColor(colors[1])
    love.graphics.rectangle("fill", x, y, width, height, roundx, roundy, segments)
    love.graphics.setColor(colors[2])
    love.graphics.rectangle("line", x, y, width - 1, height - 1, roundx, roundy, segments)
    love.graphics.setColor(dgl.color.white)
end

function drawing.printShadow(text, x, y, r, sz, sy)
    r = r or 0
    sx = sx or 1
    sy = sy or 1
    
    local red, green, blue, alpha = love.graphics.getColor()
    
    love.graphics.setColor(color.black)
    love.graphics.print(text, x + 1, y + 1, r, sx, sy)
    love.graphics.setColor(red, green, blue, alpha)
    love.graphics.print(text, x, y, r, sx, sy)
end

function drawing.getScale(x, y)
    local w, h = love.graphics.getDimensions()
    
    x = x / (w / width)
    y = y / (h / height)
    
    return x, y
end

function drawing.makeBlankImage(width, height)
    local imageData = love.image.newImageData(width, height)
    
    for i = 0, width - 1 do
        for j = 0, height - 1 do
            imageData:setPixel(i, j, 0, 0, 0, 255)
        end
    end
    
    local image = love.graphics.newImage(imageData)
    
    return image
end

function drawing.makeGradient(colors)
    local direction = colors.direction or "vertical"
    if direction == "horizontal" then
        direction = true
    elseif direction == "vertical" then
        direction = false
    else
        error("Invalid direction '" .. tostring(direction) "' for gradient.  Horizontal or vertical expected.")
    end
    
    local result = love.image.newImageData(direction and 1 or #colors, direction and #colors or 1)
    for i, color in ipairs(colors) do
        local x, y
        
        if direction then
            x, y = 0, i - 1
        else
            x, y = i - 1, 0
        end
        
        result:setPixel(x, y, color[1], color[2], color[3], color[4] or 255)
    end
    
    result = love.graphics.newImage(result)
    result:setFilter('linear', 'linear')
    
    return result
end

return drawing
