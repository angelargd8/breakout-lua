local World = require("src.ECS.world")

local Ball = {}

function Ball.create(world)
    local entity = World.createEntity(world)

    World.addComponent(world, entity, "position", {
        x = 400,
        y = 400
    })

    World.addComponent(world, entity, "size", {
        width = 25,
        height = 25
    })

    World.addComponent(world, entity, "velocity", {
        dx = 200,
        dy = -200
    })

    World.addComponent(world, entity, "color", {
        r = 0.976,
        g = 0.149,
        b = 0.447
    })

    World.addComponent(world, entity, "ball", {
        speedIncrease = 20
    })

    return entity
    
end

return Ball
