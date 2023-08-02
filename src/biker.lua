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
    self.maxSpd = 200
    self.friction = 10

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
    love.graphics.draw(Biker_assets['body'][self.body], self.x - self.width/2, self.y - self.height/2, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['bike'][self.bike], self.x - self.width/2, self.y - self.height/2, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['leg'][self.leg], self.x - self.width/2, self.y - self.height/2, self.direction, 1, 1)
    love.graphics.draw(Biker_assets['pedal'][self.pedal], self.x - self.width/2, self.y - self.height/2, self.direction, 1, 1)

    -- love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
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
        if self.velocity.x < self.maxSpd then
            self.velocity.x = self.velocity.x + self.acceleration*dt
        end
    end
    if love.keyboard.isDown('left', 'a') then
        if self.velocity.x > -self.maxSpd then
            self.velocity.x = self.velocity.x - self.acceleration*dt
        end
    end
        self:applyFriction(dt)
end


function Biker:applyFriction(dt)
    if self.velocity.x > 0 then
        self.velocity.x = math.max(self.velocity.x - self.friction*dt, 0)
    elseif self.velocity.x < 0 then
        self.velocity.x = math.max(self.velocity.x + self.friction*dt, 0)
    end
end

return Biker