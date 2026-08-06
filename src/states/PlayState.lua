local BaseState = require 'src.states.BaseState'
local Bird = require 'src.Bird'
local PipePair = require 'src.PipePair'
local PlayState = Class{__includes = BaseState}

function PlayState:init(context)
    self.context = context
    self.bird = Bird(context.images.bird, context.input, context.sounds.jump)
    self.pipePairs = {}
    self.spawnTimer = PIPE_SPAWN_INTERVAL * 0.45
    self.score = 0
    self.paused = false
    self.lastGapCenter = VIRTUAL_HEIGHT / 2
end

function PlayState:enter()
    self.context.scrolling = true
end

function PlayState:exit()
    self.context.scrolling = false
end

function PlayState:getDifficulty()
    return {
        speed = math.min(MAX_PIPE_SPEED, BASE_PIPE_SPEED + self.score * 2.5),
        gap = math.max(MIN_GAP_HEIGHT, BASE_GAP_HEIGHT - math.floor(self.score / 4) * 4)
    }
end

function PlayState:spawnPipePair(gapHeight)
    local minCenter = 48 + gapHeight / 2
    local maxCenter = GROUND_Y - 38 - gapHeight / 2
    local center = math.max(
        minCenter,
        math.min(maxCenter, self.lastGapCenter + math.random(-38, 38))
    )

    self.lastGapCenter = center
    table.insert(
        self.pipePairs,
        PipePair(self.context.images.pipe, center - gapHeight / 2, gapHeight)
    )
end

function PlayState:finishRun()
    self.context.sounds.explosion:play()
    self.context.sounds.hurt:play()
    local isRecord = self.context.highScore:register(self.score)

    self.context.stateMachine:change('score', {
        score = self.score,
        isRecord = isRecord
    })
end

function PlayState:update(dt)
    if self.context.input:wasKeyPressed('p') then
        self.paused = not self.paused
        self.context.scrolling = not self.paused
    end

    if self.paused then
        return
    end

    local difficulty = self:getDifficulty()
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= PIPE_SPAWN_INTERVAL then
        self.spawnTimer = self.spawnTimer - PIPE_SPAWN_INTERVAL
        self:spawnPipePair(difficulty.gap)
    end

    for _, pair in ipairs(self.pipePairs) do
        pair:update(dt, difficulty.speed)

        if not pair.scored and pair.x + PIPE_WIDTH < self.bird.x then
            pair.scored = true
            self.score = self.score + 1
            self.context.sounds.score:stop()
            self.context.sounds.score:play()
        end
    end

    -- Remoção reversa evita pular itens quando os índices da lista são reorganizados.
    for index = #self.pipePairs, 1, -1 do
        if self.pipePairs[index].remove then
            table.remove(self.pipePairs, index)
        end
    end

    self.bird:update(dt)

    if self.bird.y < 0 or self.bird.y + self.bird.height >= GROUND_Y then
        self:finishRun()
        return
    end

    for _, pair in ipairs(self.pipePairs) do
        for _, pipe in ipairs(pair.pipes) do
            if self.bird:collides(pipe) then
                self:finishRun()
                return
            end
        end
    end
end

function PlayState:render()
    for _, pair in ipairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.setFont(self.context.fonts.flappy)
    love.graphics.print('Pontos: ' .. self.score, 10, 10)

    love.graphics.setFont(self.context.fonts.small)
    love.graphics.printf('P: pausar', 0, 10, VIRTUAL_WIDTH - 10, 'right')

    if self.paused then
        love.graphics.setColor(0, 0, 0, 0.55)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(self.context.fonts.flappy)
        love.graphics.printf('PAUSADO', 0, 118, VIRTUAL_WIDTH, 'center')
    end
end

return PlayState
