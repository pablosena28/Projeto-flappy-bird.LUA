local HighScore = {
    filename = 'highscore.txt',
    value = 0
}

function HighScore:load()
    if love.filesystem.getInfo(self.filename) then
        local contents = love.filesystem.read(self.filename)
        self.value = math.max(0, tonumber(contents) or 0)
    end

    return self.value
end

function HighScore:register(score)
    if score <= self.value then
        return false
    end

    self.value = score
    love.filesystem.write(self.filename, tostring(score))
    return true
end

return HighScore
