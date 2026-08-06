local Pipe = Class{}

function Pipe:init(image, orientation, x, y)
    self.image = image
    self.orientation = orientation
    self.x = x
    self.y = y
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT
end

function Pipe:render()
    if self.orientation == 'top' then
        love.graphics.draw(self.image, self.x, self.y + PIPE_HEIGHT, 0, 1, -1)
    else
        love.graphics.draw(self.image, self.x, self.y)
    end
end

return Pipe
