require 'libs.buttons'

mainS = {}
mainS.isLoaded = false

function mainS:load()
    self.isLoaded = true
    buttons = require('scenes.mainButtons')
end

function mainS:update()
    mouseX, mouseY = love.mouse.getPosition()
    if not self.isLoaded then
        self:load()
    end
    for key in pairs(buttons) do
        buttons[key]:update()
    end
end

function mainS:draw()
    if self.isLoaded then
        for key in pairs(buttons) do
            buttons[key]:draw()
        end
    end
end