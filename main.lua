require 'globals'

Biker = require 'src.biker'

function love.load()
    biker = Biker:new()
    Map = STI('assets/map/map1.lua')
    background = love.graphics.newImage('assets/background.png')
end

function love.update(dt)
    biker:update(dt)
end

function love.draw()
    love.graphics.draw(background)
    biker:draw()
    Map:draw()
end