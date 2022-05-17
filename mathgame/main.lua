require 'bloques'

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)

    wHeight = love.graphics.getHeight()
    wWidth = love.graphics.getWidth()

    cubos = {}
    cubos.azul = {}
    cubos.azulN = 5

    cubos.amarillo = {}
    cubos.amarilloN = 3

    cubos.verde = {}
    cubos.verdeN = 1

    -- Creating blue cubes
    for i = 1, 9, 1 do
        table.insert(cubos.azul, NewCubo(wWidth/2 - 200, (wHeight - 30)  - (35 * i), 35, 35, 15, 1, 1, i))
    end

    -- Creating yellow cubes
    for i = 1, 9, 1 do
        table.insert(cubos.amarillo, NewCubo(wWidth/2 -160 + (35 * i), wHeight-65, 35, 35, 15, 2, 1, i))
    end

    -- Creating Green cubes
    table.insert(cubos.verde, NewCubo(wWidth/2 + 230, wHeight - 65, 35, 35, 15, 3, 1, 1))

    -- Creating green cubes
    --[[
    for i = 1, 9, 1 do
        table.insert(cubos.verde, NewCubo(wWidth/2 + 200, (wHeight - 30)  - (35 * i), 35, 35, 15, 3, 1, i))
    end --]]
end

function love.update()

end

function love.draw()
    if cubos.azulN > 0 and cubos.azulN < 10 then
        for i = 1, cubos.azulN, 1 do
            cubos.azul[i].draw()
        end
    end
    if cubos.amarilloN > 0 and cubos.amarilloN < 10 then
        for i = 1, cubos.amarilloN, 1 do
            cubos.amarillo[i].draw()
        end
    end
    cubos.verde[1].draw()

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Cubos Azules: "..cubos.azulN, 100, 100)
    love.graphics.print("Cubos Amarillos: "..cubos.amarilloN * 10, 100, 120)
    love.graphics.print("Cubos Verdes: "..cubos.verdeN * 100, 100, 140)
end

function convertRGB(r, g, b, a)
    local alfa = a or 255
    local color = {r / 255, g / 255, b / 255, alfa}
    return color
end