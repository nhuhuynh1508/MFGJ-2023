local Spike = Class('Spike')

local spikeImage = love.graphics.newImage('assets/spike/spike.png')

local ActiveSpikes = {}

Spike.width = spikeImage:getWidth()
Spike.height = spikeImage:getHeight()

function Spike:initialize(x, y)
    self.x = x
    self.y = y

    --Physics
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, 'static')
    self.physics.shape = love.physics.newRectangleShape(0, 0, spikeImage:getWidth(), spikeImage:getHeight())
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
    self.physics.fixture:setSensor(true)

    self.damage = 1
end

function Spike:draw()
    love.graphics.draw(spikeImage, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end

function Spike:update(dt)
end

function Spike:beginContact(a, b, coll)
    if (a == self.physics.fixture) and (b == biker.physics.fixture) then
        biker:takeDamage()
    elseif (a == biker.physics.fixture) and (b == self.physics.fixture) then
        biker:takeDamage()
    end
    print('Spike touched')
end

return Spike