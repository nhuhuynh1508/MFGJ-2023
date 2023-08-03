require 'globals'
require 'assets'

Biker = require 'src.biker'
Time = 0


function love.load()
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    biker = Biker:new()
    --add physics to the world
    Map = STI('assets/map/map1.lua', {"box2d"})
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    background = love.graphics.newImage('assets/background.png')
end

function love.update(dt)
    Time = Time + dt
    biker:update(dt)
    World:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    biker:draw()
    Map:draw()
end

function beginContact(a, b, coll)
    print('beginContact')
    biker:beginContact(a, b, coll)
end

function endContact(a, b, coll)
    print('endContact')
    biker:endContact(a, b, coll)
end

function love.keypressed(key)
    biker:keypressed(key)
end