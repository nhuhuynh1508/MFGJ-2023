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
    self.ny = -1
    self.dimensionTouched = 0

    -- Movement
    self.x = 100
    self.y = 100
    self.width = 64
    self.height = 64
    self.acceleration = 100
    self.velocity = {x = 0, y = 100}
    self.maxSpd = 300
    self.friction = 0.5
    self.isGrounded = false
    self.jumpVal = 200
    self.gravity = 500
    self.direction = 0

    -- Physics
    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, 'dynamic')
    self.physics.body:setFixedRotation(false)
    self.physics.shape = love.physics.newCircleShape(self.width/2)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function Biker:update(dt)
    -- Direction updating
    if (math.atan2(self.ny, self.nx) + math.pi/2 > -math.pi/2) or (math.atan2(self.ny, self.nx) + math.pi/2 < math.pi/2) then
        self.direction = math.atan2(self.ny, self.nx) + math.pi/2
    end

    -- Graphics updating
    self:updateGraphics(dt)

    --Movement updating
    self:updateMovement(dt)
    
end

function Biker:draw()
    love.graphics.draw(Biker_assets['body'][self.body], self.x, self.y, self.direction, 1, 1, self.width/2, self.height/2)
    love.graphics.draw(Biker_assets['bike'][self.bike], self.x, self.y, self.direction, 1, 1, self.width/2, self.height/2)
    love.graphics.draw(Biker_assets['leg'][self.leg], self.x, self.y, self.direction, 1, 1, self.width/2, self.height/2)
    love.graphics.draw(Biker_assets['pedal'][self.pedal], self.x, self.y, self.direction, 1, 1, self.width/2, self.height/2)

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
        if self.velocity.x > 0 then
            self.velocity.x = self.velocity.x * math.pow(0.5, dt)
        end
        if self.velocity.x > -50 then
            self.velocity.x = self.velocity.x - self.acceleration * 0.5 * dt
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
    self.dimensionTouched = self.dimensionTouched + 1
    self.nx, self.ny = coll:getNormal()
    print(self.nx, self.ny)
    if a == self.physics.fixture then
        if self.ny >= 0 then
            self:land()
        end
    elseif b == self.physics.fixture then
        if self.ny <= 0 then
            self:land()
        end
    end
    print('Dimension:', self.dimensionTouched)

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
    self.dimensionTouched = self.dimensionTouched - 1
    if self.dimensionTouched == 0 then
        self.isGrounded = false
    end
    print('Dimension: ',self.dimensionTouched)
end

return Biker