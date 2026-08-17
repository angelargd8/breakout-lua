local PaddleCollisionSystem = {}

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


local function rectanglesOverlap(positionA, sizeA, positionB, sizeB)

    return positionA.x < positionB.x + sizeB.width 
        and positionA.x + sizeA.width > positionB.x
        and positionA.y < positionB.y + sizeB.height
        and positionA.y + sizeA.height > positionB.y

end


function PaddleCollisionSystem.update(world)

    for ballEntity, ball in pairs(world.components.ball) do
        local ballPosition = world.components.position[ballEntity]
        local ballSize = world.components.size[ballEntity]
        local ballVelocity = world.components.velocity[ballEntity]

        if ballVelocity.dy > 0 then
            for paddleEntity in pairs(world.components.paddle) do
                local paddlePosition = world.components.position[paddleEntity]
                local paddleSize = world.components.size[paddleEntity]

                if rectanglesOverlap(ballPosition, ballSize, paddlePosition, paddleSize) then
                    ballPosition.y = paddlePosition.y - ballSize.height
                    ballVelocity.dy = -math.abs(ballVelocity.dy)
                    increaseSpeed(ballVelocity, ball.speedIncrease)
                    return
                end

            end
        end

    end

end

return PaddleCollisionSystem
