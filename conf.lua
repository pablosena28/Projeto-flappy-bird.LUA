function love.conf(t)
    t.identity = 'projeto-flappy-bird-lua'
    t.version = '11.3'
    t.console = false

    t.window.title = 'Flappy Bird | Projeto em Lua'
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
    t.window.vsync = 1
    t.window.minwidth = 640
    t.window.minheight = 360
end
