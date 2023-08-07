require 'globals'
require 'assets'

Biker = require 'src.biker'
Spike = require 'src.spike'
Camera = require 'lib.camera'
Time = 0
ActiveSpikes = {}


function love.load()
    cam = Camera()
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    biker = Biker:new()
    --add physics to the world
    Map = STI('assets/map/map1.lua', {"box2d"})
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    background = love.graphics.newImage('assets/background.png')

    ---Spike
    spike1 = Spike(200, 200)
    spike2 = Spike(100, 500)
    spike3 = Spike(300, 340)
    spike4 = Spike(400, 310)
    spike5 = Spike(500, 280)
    ActiveSpikes = {spike1, spike2, spike3, spike4, spike5}
end

function love.update(dt)
    Time = Time + dt
    biker:update(dt)
    World:update(dt)

    cam:lookAt(biker.x, biker.y - 150)
end

function love.draw()
    cam:attach()
        love.graphics.draw(background, 0, 0)
        Map:drawLayer(Map.layers["Tile Layer 1"])
        for i = 1, 5 do
            ActiveSpikes[i]:draw()
        end
        biker:draw()
    cam:detach()
end

function beginContact(a, b, coll)
    if spike1:beginContact(a, b, coll) then return end
    biker:beginContact(a, b, coll)
end

function endContact(a, b, coll)
    print('endContact')
    biker:endContact(a, b, coll)
end

function love.keypressed(key)
    biker:keypressed(key)
end