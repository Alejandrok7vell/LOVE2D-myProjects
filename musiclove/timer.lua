timer = {}

function timer.load()
   timer.loaded = love.timer.getTime()
   timer.isOn = true
end

function timer.getTime()
   if timer.isOn then
      return love.timer.getTime() - timer.loaded
   else
      return 0
   end
end

function timer.stop()
   timer.isOn = false
end