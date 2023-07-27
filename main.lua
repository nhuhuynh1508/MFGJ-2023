require 'globals'
require 'assets'

Biker = require 'src.biker'
Time = 0

function love.load()
    biker = Biker:new()
    Map = STI('assets/map/map1.lua')
    background = love.graphics.newImage('assets/background.png')
end

function love.update(dt)
    Time = Time + dt
    biker:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    biker:draw()
    Map:draw()
end