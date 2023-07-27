local Biker = Class('Biker')

function Biker:initialize()
    self.x = 100
    self.y = 100
    self.speed = 0
    self.direction = 0
    self.body = 1
    self.bike = 1
    self.leg = 2
    self.pedal = 2
    self.pedalRatio = 3
end

function Biker:update(dt)
    -- self.x = self.x + self.speed * dt
    
    self.bike = math.floor((Time*3*self.speed*self.pedalRatio) % 3) + 1
    self.leg = math.floor((Time*24*self.speed) % 24) + 1
    self.pedal = math.floor((Time*24*self.speed) % 24) + 1
    self.body = math.floor(self.speed * 2.5) + 1

    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.speed = self.speed + 0.1*dt
    end
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.speed = self.speed - 0.1*dt
    end
    
    if self.speed > 2 then
        self.speed = 2
    end
    print(self.speed)
end

function Biker:draw()
    love.graphics.draw(Biker_assets['body'][self.body], self.x, self.y, self.direction, 1, 1, 0, 0)
    love.graphics.draw(Biker_assets['bike'][self.bike], self.x, self.y, self.direction, 1, 1, 0, 0)
    love.graphics.draw(Biker_assets['leg'][self.leg], self.x, self.y, self.direction, 1, 1, 0, 0)
    love.graphics.draw(Biker_assets['pedal'][self.pedal], self.x, self.y, self.direction, 1, 1, 0, 0)
end

return Biker