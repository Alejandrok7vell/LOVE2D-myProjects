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

   team = 2

   balls = {}
   ballsLength = 3
   ballsStoped = 0
   for i = 1, ballsLength, 1 do
      table.insert(balls, newBall())
   end

   balls[1]:load(200, 200, 50)
   balls[2]:load(400, 300, 50, 2)
   balls[3]:load(500, 100, 50, 2)

   for key in pairs(balls) do
      balls[key]:setCurrentTeam(team)
   end
   paredes:load()
end

function love.update(dt)
   world:update(dt)

   for key in pairs(balls) do
      balls[key]:update()
   end

   areBallsStoped()

   mouseX, mouseY = love.mouse.getPosition()
end

function love.draw()
   for key in pairs(balls) do
      balls[key]:draw()
      balls[key]:drawLine()
   end
end

function areBallsStoped()
   if balls[1].isStop and
      balls[2].isStop and
      balls[3].isStop then
         for i = 1, ballsLength, 1 do
            balls[i].ready = true
         end
      else
         for i = 1, ballsLength, 1 do
            balls[i].ready = false
         end
   end
end