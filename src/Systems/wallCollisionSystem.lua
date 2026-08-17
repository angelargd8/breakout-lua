local WallCollisionSystem = {}


local function increaseSpeed(velocity, amount)
    if velocity.dx < 0 then
        velocity.dx = velocity.dx - amount
    elseif velocity.dx > 0 then
        velocity.dx = velocity.dx + amount
    end

    if velocity.dy < 0 then
        velocity.dy = velocity.dy - amount
    elseif velocity.dy > 0 then
        velocity.dy = velocity.dy + amount
    end
end


function WallCollisionSystem.update(world, gameState, windowWidth, windowHeight)
    for entity, ball in pairs(world.components.ball) do
        local position = world.components.position[entity]
        local size = world.components.size[entity]
        local velocity = world.components.velocity[entity]

        if position.x <= 0 then
            position.x = 0
            velocity.dx = math.abs(velocity.dx)
            increaseSpeed(velocity, ball.speedIncrease)
        end

        if position.x + size.width >= windowWidth then
            position.x = windowWidth - size.width
            velocity.dx = -math.abs(velocity.dx)
            increaseSpeed(velocity, ball.speedIncrease)
        end

        if position.y <= 0 then
            position.y = 0
            velocity.dy = math.abs(velocity.dy)
            increaseSpeed(velocity, ball.speedIncrease)
        end

        if position.y + size.height >= windowHeight then
            gameState.finished = true
            gameState.message = "game over"
            print(gameState.message)
            love.event.quit()
        end
    end
end


return WallCollisionSystem
