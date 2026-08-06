local StateMachine = Class{}

function StateMachine:init(states)
    self.states = states or {}
    self.current = {
        enter = function() end,
        exit = function() end,
        update = function() end,
        render = function() end
    }
end

function StateMachine:change(name, params)
    assert(self.states[name], 'Estado inexistente: ' .. tostring(name))
    self.current:exit()
    self.current = self.states[name]()
    self.current:enter(params or {})
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end

return StateMachine
