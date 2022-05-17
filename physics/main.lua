require 'ball'
require 'libs.trigonometry'

function love.load()
   love.graphics.setBackgroundColor(0.1, 0.3, 1)
   mouseP = false
   mouseP2 = false

   mouseX, mouseY = love.mouse.getPosition()

   love.physics.setMeter(64)
   world = love.physics.newWorld(0, 0)

   ball:load()
end

function love.update(dt)
   world:update(dt)

   ball:update(dt)

   mouseX, mouseY = love.mouse.getPosition()
end

function love.draw()
   ball:draw()
   love.graphics.print(angle(mouseX, mouseY, ball.body:getX(), ball.body:getY()))
   love.graphics.print(angle(mouseX, mouseY, ball.body:getX(), ball.body:getY(), true), 0, 50)

   love.graphics.setColor(0,0,0)
   love.graphics.line(mouseX, mouseY, ball.body:getX(), ball.body:getY())
end