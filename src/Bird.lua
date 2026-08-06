local Bird = Class{}

function Bird:init(image, input, jumpSound)
    self.image = image
    self.input = input
    self.jumpSound = jumpSound
    self.width = image:getWidth()
    self.height = image:getHeight()
    self.x = VIRTUAL_WIDTH * 0.35 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
    self.rotation = 0
end

function Bird:update(dt)
    if self.input:wasActionPressed('flap') then
        self.dy = BIRD_FLAP_VELOCITY
        self.jumpSound:stop()
        self.jumpSound:play()
    end

    -- A aceleração e o deslocamento usam dt; assim a física não muda com o FPS.
    self.dy = self.dy + BIRD_GRAVITY * dt
    self.y = self.y + self.dy * dt

    local targetRotation = self.dy < 0 and math.rad(-20)
        or math.min(math.rad(90), self.dy / 500)
    self.rotation = self.rotation + (targetRotation - self.rotation) * math.min(1, 8 * dt)
end

function Bird:collides(pipe)
    -- Margens menores que o sprite deixam a caixa de colisão mais justa ao jogador.
    local marginX, marginY = 4, 3
    local left = self.x + marginX
    local right = self.x + self.width - marginX
    local top = self.y + marginY
    local bottom = self.y + self.height - marginY

    return right >= pipe.x and left <= pipe.x + pipe.width
        and bottom >= pipe.y and top <= pipe.y + pipe.height
end

function Bird:render()
    love.graphics.draw(
        self.image,
        self.x + self.width / 2,
        self.y + self.height / 2,
        self.rotation,
        1,
        1,
        self.width / 2,
        self.height / 2
    )
end

return Bird
