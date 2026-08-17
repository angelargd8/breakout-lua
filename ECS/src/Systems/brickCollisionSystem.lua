local World = require("src.ECS.world")

local BrickCollisionSystem = {}



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


function BrickCollisionSystem.update(world, gameState)

    for ballEntity, ball in pairs(world.components.ball) do
        local ballPosition = world.components.position[ballEntity]
        local ballSize = world.components.size[ballEntity]
        local ballVelocity = world.components.velocity[ballEntity]

        for brickEntity in pairs(world.components.brick) do
            local brickPosition = world.components.position[brickEntity]
            local brickSize = world.components.size[brickEntity]

            if rectanglesOverlap(ballPosition, ballSize, brickPosition, brickSize) then
                World.removeEntity(world, brickEntity)
                ballVelocity.dy = -ballVelocity.dy
                increaseSpeed(ballVelocity, ball.speedIncrease)

                if World.countComponents(world, "brick") == 0 then
                    gameState.finished = true
                    gameState.message = "you win"
                    print(gameState.message)
                    love.event.quit()
                end

                return
            end

        end


    end


end

return BrickCollisionSystem
