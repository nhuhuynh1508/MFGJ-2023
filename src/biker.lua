local Biker = Class('Biker')

function Biker:initialize()
    -- Graphics loading
    self.body = 1
    self.bike = 1
    self.leg = 2
    self.pedal = 2
    self.rotation = 0
    self.pedalRatio = 3
    self.nx = 0
    self.ny = 0

    -- Movement
    self.x = 100
    self.y = 100
    self.width = 64
    self.height = 64
    self.acceleration = 300
    self.velocity = {x = 0, y = 100}
    self.maxSpd = 200
    self.friction = 0.5
    self.isGrounded = false
    self.jumpVal = 200
    self.gravity = 500

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
    self.rotation = self.rotation + self.velocity.x*dt * 0.2
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
    self:applyGravity(dt)
end

function Biker:keypressed(key)
    if key == 'space' or key == 'w' or key == "up" then
        self:jump()
    end
end

function Biker:jump()
    if self.isGrounded then
        self.isGrounded = false
        self.velocity.y = -self.jumpVal
    end
end

function Biker:applyFriction(dt)
    self.velocity.x = self.velocity.x * math.pow(self.friction, dt)
end

function Biker:beginContact(a, b, coll)
    self.nx, self.ny = coll:getNormal()
    print(self.nx, self.ny)
    if a == self.physics.fixture then
        if self.ny > 0 then
            self:land()
        end
    elseif b == self.physics.fixture then
        if self.ny < 0 then
            self:land()
        end
    end
end

function Biker:land()
    self.isGrounded = true
    self.velocity.y = 0
    print('landed')
end

function Biker:applyGravity(dt)
    if not self.isGrounded then
        if self.velocity.y < 500 then
            self.velocity.y = self.velocity.y + self.gravity*dt
        end
    end
end

function Biker:endContact(a, b, coll)
    self.isGrounded = false
end

return Biker