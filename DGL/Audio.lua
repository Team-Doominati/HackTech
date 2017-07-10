local audio =
{
    sound = nil
}

function audio.playSound(path)
    audio.sound = love.audio.newSource(path, "static")
    audio.sound:play()
end

return audio
