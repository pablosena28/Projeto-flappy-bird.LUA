local Pipe = require 'src.Pipe'
local PipePair = Class{}

function PipePair:init(image, gapTop, gapHeight)
    self.x = PIPE_START_X
    self.scored = false
    self.remove = false

    self.pipes = {
        Pipe(image, 'top', self.x, gapTop - PIPE_HEIGHT),
        Pipe(image, 'bottom', self.x, gapTop + gapHeight)
    }
end

function PipePair:update(dt, speed)
    self.x = self.x - speed * dt

    for _, pipe in ipairs(self.pipes) do
        pipe.x = self.x
    end

    self.remove = self.x + PIPE_WIDTH < 0
end

function PipePair:render()
    for _, pipe in ipairs(self.pipes) do
        pipe:render()
    end
end

return PipePair
