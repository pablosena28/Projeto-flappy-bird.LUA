local BaseState = require 'src.states.BaseState'
local CountdownState = Class{__includes = BaseState}

local STEP_DURATION = 0.75

function CountdownState:init(context)
    self.context = context
    self.count = 3
    self.timer = 0
end

function CountdownState:enter()
    self.context.scrolling = true
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer >= STEP_DURATION then
        self.timer = self.timer - STEP_DURATION
        self.count = self.count - 1

        if self.count == 0 then
            self.context.stateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(self.context.fonts.huge)
    love.graphics.printf(tostring(self.count), 0, 105, VIRTUAL_WIDTH, 'center')
end

return CountdownState
