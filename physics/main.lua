require 'ball'
require 'winMargin'
require 'libs.trigonometry'

function love.load()
   love.graphics.setBackgroundColor(0.1, 0.3, 1)

   winW, winH = love.graphics.getDimensions()

   mouseP = false

   mouseX, mouseY = love.mouse.getPosition()

   love.physics.setMeter(64)
   world = love.physics.newWorld(0, 0)

   balls = {}
   for i = 1, 2, 1 do
      table.insert(balls, newBall())
   end

   balls[1]:load(200, 200)
   paredes:load()
end

function love.update(dt)
   world:update(dt)

   for key in pairs(balls) do
      balls[key]:update()
   end

   mouseX, mouseY = love.mouse.getPosition()
end

function love.draw()
   for key in pairs(balls) do
      balls[key]:draw()
      balls[key]:drawLine()
   end
end