require 'globals'

Biker = require 'src.biker'

function love.load()
    biker = Biker:new()
end

function love.update(dt)
    biker:update(dt)
end

function love.draw()
    biker:draw()
end