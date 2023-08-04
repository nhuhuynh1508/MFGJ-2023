local Spike = Class('Spike')

local spikeImage = love.graphics.newImage('assets/spike/wooden-spike.png')

function Spike:initialize()
    --physics loading
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, 'static')
    self.physics.shape = love.physics.newRectangleShape(0, 0, spikeImage:getWidth(), spikeImage:getHeight())
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)

    self.damage = 1
end

function Spike:draw()
    for i = 1, 3 do 
        love.graphics.draw(spikeImage, 45 + 210 * i, 527)
    end
end

function Spike:update(dt)
end

function Spike:beginContact(a, b, coll)
end

return Spike
