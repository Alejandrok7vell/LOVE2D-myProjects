mainS = {}
mainS.isLoaded = false

function mainS:load()
    self.isLoaded = true
end

function mainS:update()
    if not self.isLoaded then
        self:load()
    end
end

function mainS:draw()
    if self.isLoaded then

    end
end