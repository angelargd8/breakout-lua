local World = require("src.ECS.world")

local Paddle = {}


function Paddle.create(world)

    local entity = World.createEntity(world)

    World.addComponent(world, entity, "position", {
        x = 360,
        y = 560
    })

    World.addComponent(world, entity, "size", {
        width = 100,
        height = 20
    })

    World.addComponent(world, entity, "color", {
        r = 1,
        g = 1,
        b = 1
    })

    World.addComponent(world, entity, "paddle", {
        speed = 500
    })

    return entity

end

return Paddle
