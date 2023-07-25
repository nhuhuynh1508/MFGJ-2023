local Biker = Class('Biker')

function Biker:initialize()
    self.x = 100
    self.y = 100
    self.speed = 0
    self.direction = 0
    self.sprite = love.graphics.newImage('assets/Biker-bike-1.png')
end

function Biker:update(dt)
    self.x = self.x + self.speed * dt
end

function Biker:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.direction, 1, 1, self.sprite:getWidth() / 2, self.sprite:getHeight() / 2)
end

return Biker