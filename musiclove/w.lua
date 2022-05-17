require 'g1'

g = {}

function g.load()
   love.graphics.setBackgroundColor(rgb(31, 31, 31))
   game.load()
end

function g.update()
   game.update()
end

function g.draw()
   game.draw()
end