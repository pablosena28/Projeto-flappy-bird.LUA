local BaseState = require 'src.states.BaseState'
local TitleState = Class{__includes = BaseState}

function TitleState:init(context)
    self.context = context
end

function TitleState:enter()
    self.context.scrolling = true
end

function TitleState:update()
    if self.context.input:wasActionPressed('confirm') then
        self.context.stateMachine:change('countdown')
    end
end

function TitleState:render()
    love.graphics.setFont(self.context.fonts.huge)
    love.graphics.printf('FLAPPY BIRD', 0, 58, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(self.context.fonts.medium)
    love.graphics.printf('Lua + LÖVE2D', 0, 108, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(self.context.fonts.small)
    love.graphics.printf(
        'ESPAÇO, SETA PARA CIMA ou CLIQUE para voar',
        0,
        164,
        VIRTUAL_WIDTH,
        'center'
    )
    love.graphics.printf('Pressione ENTER, ESPAÇO ou clique para começar', 0, 185, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Recorde: ' .. self.context.highScore.value, 0, 215, VIRTUAL_WIDTH, 'center')
end

return TitleState
