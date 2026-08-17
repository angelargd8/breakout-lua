local RenderSystem = {}


function RenderSystem.draw(world, gameState)
    for entity in pairs(world.entities) do
        local position = world.components.position[entity]
        local size = world.components.size[entity]
        local color = world.components.color[entity]

        if position and size and color then
            love.graphics.setColor(color.r, color.g, color.b)
            love.graphics.rectangle("fill", position.x, position.y, size.width, size.height)
        end
    end

    if gameState.message then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(gameState.message, 0, 280, 800, "center")
    end
end

return RenderSystem
