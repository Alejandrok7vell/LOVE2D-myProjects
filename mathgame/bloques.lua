function NewCubo(x, y, w, h, z, b, t, n)
    local c = {}
    c.x = x or 100
    c.y = y or 100
    c.w = w or 100
    c.h = h or 100
    c.z = z or 20

    c.b = b or 1

    c.t = t or 1

    c.selected = false

    c.colors = {}
    --Hue = 204
    c.colors.b1 = convertRGB(89, 190, 255) -- s=65, v=100
    c.colors.b2 = convertRGB(145, 210, 250) -- s=42, v=98
    c.colors.b3 = convertRGB(80, 161, 212) -- s=62, v=83
    c.colors.b4 = convertRGB(35, 75, 102) -- s=65, v=40

    --Hue = 62
    c.colors.y1 = convertRGB(248, 255, 89)
    c.colors.y2 = convertRGB(247, 250, 145)
    c.colors.y3 = convertRGB(206, 212, 80)
    c.colors.y4 = convertRGB(100, 102, 35)

    -- Hue 120
    c.colors.g1 = convertRGB(89, 255, 90)
    c.colors.g2 = convertRGB(145, 250, 145)
    c.colors.g3 = convertRGB(80, 212, 81)
    c.colors.g4 = convertRGB(35, 102, 35)

    if c.b == 1 then
        c.color1 = c.colors.b1
        c.color2 = c.colors.b2
        c.color3 = c.colors.b3
        c.color4 = c.colors.b4
    elseif c.b == 2 then
        c.color1 = c.colors.y1
        c.color2 = c.colors.y2
        c.color3 = c.colors.y3
        c.color4 = c.colors.y4
    elseif c.b == 3 then
        c.color1 = c.colors.g1
        c.color2 = c.colors.g2
        c.color3 = c.colors.g3
        c.color4 = c.colors.g4
    end

    function c.draw()
        if not c.selected then
            -- Drawing blue cube
            if c.b == 1 then
                c.createCube(c.x, c.y)
            elseif c.b == 2 then
                -- Drawing Yellow cubes
                for i = 1, 10, 1 do
                    c.createCube(c.x, c.y + c.h - (c.h * i))
                end
            elseif c.b == 3 then
                -- Drawing Green cubes
                for i = 1, 10, 1 do
                    for a = 1, 10, 1 do
                        c.createCube(c.x - c.w + (c.w * i), c.y + c.h - (c.h * a))
                    end
                end
            end
        end
    end

    function c.update()
        if c.selected then
            
        end
    end

    function c.createCube(x, y)
        love.graphics.setColor(c.color1) -- Cuadrado front
        love.graphics.rectangle("fill", x, y, c.w, c.h)
        love.graphics.setColor(c.color2) -- Cuadrado front
        love.graphics.polygon("fill", x, y, x + c.z, y - c.z, x + c.w + c.z, y - c.z, x + c.w, y)
        love.graphics.setColor(c.color3)
        love.graphics.polygon("fill", x + c.w, y, x + c.w + c.z, y - c.z, x + c.w + c.z, y + c.h - c.z, x + c.w, y + c.h)
        love.graphics.setColor(c.color4)
        love.graphics.rectangle("line", x, y, c.w, c.h)
        -- up face
        love.graphics.line(x, y, x + c.z, y - c.z)
        love.graphics.line(x + c.z, y - c.z, x + c.w + c.z, y - c.z)
        love.graphics.line(x + c.w + c.z, y - c.z, x + c.w, y)
        love.graphics.line(x, y, x + c.w, y)
        -- right face
        love.graphics.line(x + c.w, y, x + c.w + c.z, y - c.z)
        love.graphics.line(x + c.w + c.z, y - c.z, x + c.w + c.z, y + c.h - c.z)
        love.graphics.line(x + c.w + c.z, y + c.h - c.z, x + c.w, y + c.h)
        love.graphics.line(x + c.w, y, x + c.w, y + c.h)
    end

    return c
end