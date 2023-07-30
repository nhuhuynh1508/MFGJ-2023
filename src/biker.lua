local Biker = Class('Biker')

function Biker:initialize()
    -- Graphics loading
    self.body = 1
    self.bike = 1
    self.leg = 2
    self.pedal = 2
    self.rotation = 0
    self.pedalRatio = 3

    -- Movement
    self.x = 100
    self.y = 100
    self.width = 64
    self.height = 64
    self.acceleration = 300
    self.velocity = {x = 0, y = 100}
    self.maxSpd = 600

    -- Physics
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, 'dynamic')
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function Biker:update(dt)
    -- Graphics updating
    self:updateGraphics(dt)

    --Movement updating
    self:updateMovement(dt)
    
end

function Biker:draw()
    love.graphics.draw(Biker_assets['body'][self.body], self.x, self.y, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['bike'][self.bike], self.x, self.y, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['leg'][self.leg], self.x, self.y, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['pedal'][self.pedal], self.x, self.y, self.direction, 1, 1)
end

function Biker:updateGraphics(dt)
    self.rotation = self.rotation + self.velocity.x*dt
    self.bike = math.floor(self.rotation % 3) + 1
    self.leg = math.floor((self.rotation * self.pedalRatio) % 24) + 1
    self.pedal = math.floor((self.rotation * self.pedalRatio) % 24) + 1
    
end

function Biker:updateMovement(dt)
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.velocity.x, self.velocity.y)

    if love.keyboard.isDown('right', 'd') then
        self.velocity.x = self.velocity.x + self.acceleration*dt
    end
    if love.keyboard.isDown('left', 'a') then
        self.velocity.x = self.velocity.x - self.acceleration*dt
    end
    -- if self.velocity > 2 then
    --     self.speed = 2
    -- end
end

return Biker