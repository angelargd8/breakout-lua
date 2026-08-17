local MovementSystem = {}


function MovementSystem.update(world, dt)

    for entity, velocity in pairs(world.components.velocity) do
        local position = world.components.position[entity]

        if position then
            position.x = position.x + velocity.dx * dt
            position.y = position.y + velocity.dy * dt
        end
        
    end
end

return MovementSystem
