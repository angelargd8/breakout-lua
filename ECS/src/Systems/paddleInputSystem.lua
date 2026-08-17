local PaddleInputSystem = {}



function PaddleInputSystem.update(world, dt, windowWidth)
    for entity, paddle in pairs(world.components.paddle) do
        local position = world.components.position[entity]
        local size = world.components.size[entity]

        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            position.x = position.x - paddle.speed * dt
        end

        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            position.x = position.x + paddle.speed * dt
        end

        if position.x < 0 then
            position.x = 0
        end

        if position.x + size.width > windowWidth then
            position.x = windowWidth - size.width
        end
    end
end

return PaddleInputSystem
