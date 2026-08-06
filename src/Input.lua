local Input = {
    keysPressed = {},
    mousePressed = {}
}

function Input:keypressed(key)
    self.keysPressed[key] = true
end

function Input:mousepressed(button)
    self.mousePressed[button] = true
end

function Input:wasKeyPressed(key)
    return self.keysPressed[key] == true
end

function Input:wasMousePressed(button)
    return self.mousePressed[button] == true
end

function Input:wasActionPressed(action)
    if action == 'confirm' then
        return self:wasKeyPressed('return') or self:wasKeyPressed('kpenter')
            or self:wasKeyPressed('space') or self:wasMousePressed(1)
    end

    if action == 'flap' then
        return self:wasKeyPressed('space') or self:wasKeyPressed('up')
            or self:wasMousePressed(1)
    end

    return false
end

function Input:endFrame()
    self.keysPressed = {}
    self.mousePressed = {}
end

return Input
