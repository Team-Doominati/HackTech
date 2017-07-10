local music =
{
    layers = {},
	song = nil
}

function music.addLayer(path, play)
    local layer = love.audio.newSource(path, "stream")
    
    layer:setVolume(0.0)
    layer:setLooping(true)
    
    table.insert(music.layers, layer)
    
    if play then
        love.audio.play(layer)
    end
end

function music.removeLayer(id)
    table.remove(music.layers, id)
end

function music.playLayer(id, fadeTime)
    fadeTime = fadeTime or 0.5
    
    local volume = { music.layers[id]:getVolume() }
    
    love.audio.play(music.layers[id])
    
    flux.to(volume, fadeTime, { [1] = 1.0 }):onupdate(
        function()
            music.layers[id]:setVolume(volume[1])
        end)
    
    music.syncMusic()
end

function music.stopLayer(id, fadeTime)
    fadeTime = fadeTime or 0.5
    
    local volume = { music.layers[id]:getVolume() }
    
    flux.to(volume, fadeTime, { [1] = 0.0 }):onupdate(
        function()
            music.layers[id]:setVolume(volume[1])
        end):oncomplete(
        function()
            love.audio.stop(music.layers[id])
        end)
    
    if id == 1 and #music.layers > 1 then
        for i = 2, #music.layers do
            music.StopLayer(i)
        end
    end
end

function music.isLayerPlaying(id)
    return music.layers[id]:isPlaying()
end

function music.syncMusic()
    if #music.layers <= 1 then return end
    
    local pos = music.layers[1]:tell()
    
    for i = 2, #music.layers do
        music.layers[i]:seek(pos)
    end
end

function music.playRandomSong(dir)
    dir = dir .. "/"
    
    local files = love.filesystem.getDirectoryItems(dir)
    
    if #files == 0 then
        dgl.console.log("music.playRandomSong(): No files found in the specified directory", dgl.logLevel.warning)
        return
    end
    
    if music.song and music.song:isPlaying() then
        music.song:stop()
    end
    
    local file = dir .. files[math.random(1, #files)]
    
    music.song = love.audio.newSource(file, "stream")
    music.song:play()
    
    print("Playing song " .. file)
end

return music
