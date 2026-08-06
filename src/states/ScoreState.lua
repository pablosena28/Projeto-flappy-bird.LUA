local BaseState = require 'src.states.BaseState'
local ScoreState = Class{__includes = BaseState}

function ScoreState:init(context)
    self.context = context
    self.score = 0
    self.isRecord = false
end

function ScoreState:enter(params)
    self.score = params.score or 0
    self.isRecord = params.isRecord or false
end

function ScoreState:update()
    if self.context.input:wasActionPressed('confirm') then
        self.context.stateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(self.context.fonts.flappy)
    love.graphics.printf('FIM DE JOGO', 0, 54, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(self.context.fonts.medium)
    love.graphics.printf('Pontuação: ' .. self.score, 0, 98, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Recorde: ' .. self.context.highScore.value, 0, 121, VIRTUAL_WIDTH, 'center')

    if self.isRecord then
        love.graphics.setColor(1, 0.85, 0.2, 1)
        love.graphics.printf('NOVO RECORDE!', 0, 150, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.setFont(self.context.fonts.small)
    love.graphics.printf('Pressione ENTER, ESPAÇO ou clique para jogar novamente', 0, 198, VIRTUAL_WIDTH, 'center')
end

return ScoreState
