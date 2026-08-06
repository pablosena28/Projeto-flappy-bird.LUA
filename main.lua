local push = require 'lib.push'
Class = require 'lib.class'

require 'src.constants'

local Input = require 'src.Input'
local StateMachine = require 'src.StateMachine'
local HighScore = require 'src.HighScore'
local TitleState = require 'src.states.TitleState'
local CountdownState = require 'src.states.CountdownState'
local PlayState = require 'src.states.PlayState'
local ScoreState = require 'src.states.ScoreState'

local backgroundScroll = 0
local groundScroll = 0
local context

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    local images = {
        background = love.graphics.newImage('assets/sprites/background.png'),
        ground = love.graphics.newImage('assets/sprites/ground.png'),
        bird = love.graphics.newImage('assets/sprites/bird.png'),
        pipe = love.graphics.newImage('assets/sprites/pipe.png')
    }

    local fonts = {
        small = love.graphics.newFont('assets/fonts/font.ttf', 8),
        medium = love.graphics.newFont('assets/fonts/flappy.ttf', 14),
        flappy = love.graphics.newFont('assets/fonts/flappy.ttf', 28),
        huge = love.graphics.newFont('assets/fonts/flappy.ttf', 48)
    }

    local sounds = {
        jump = love.audio.newSource('assets/sounds/jump.wav', 'static'),
        explosion = love.audio.newSource('assets/sounds/explosion.wav', 'static'),
        hurt = love.audio.newSource('assets/sounds/hurt.wav', 'static'),
        score = love.audio.newSource('assets/sounds/score.wav', 'static')
    }

    HighScore:load()

    context = {
        images = images,
        fonts = fonts,
        sounds = sounds,
        input = Input,
        highScore = HighScore,
        scrolling = true
    }

    context.stateMachine = StateMachine {
        title = function() return TitleState(context) end,
        countdown = function() return CountdownState(context) end,
        play = function() return PlayState(context) end,
        score = function() return ScoreState(context) end
    }
    context.stateMachine:change('title')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        pixelperfect = true
    })
end

function love.resize(width, height)
    push:resize(width, height)
end

function love.keypressed(key)
    Input:keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(_, _, button)
    Input:mousepressed(button)
end

function love.update(dt)
    -- Limita saltos temporais após a janela ficar suspensa.
    dt = math.min(dt, 1 / 20)

    if context.scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
    end

    context.stateMachine:update(dt)
    Input:endFrame()
end

function love.draw()
    push:start()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(context.images.background, -backgroundScroll, 0)
    context.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(context.images.ground, -groundScroll, GROUND_Y)

    push:finish()
end
