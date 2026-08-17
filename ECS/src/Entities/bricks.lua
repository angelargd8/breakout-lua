local World = require("src.ECS.world")

local Bricks = {}

function Bricks.createAll(world)

    local rows = 3
    local columns = 4
    local blockWidth = 170
    local blockHeight = 60
    local gap = 12
    local startX = 42
    local startY = 60

    for row = 1, rows do
        for column = 1, columns do
            local entity = World.createEntity(world)

            World.addComponent(world, entity, "position", {
                x = startX + (column - 1) * (blockWidth + gap),
                y = startY + (row - 1) * (blockHeight + gap)
            })

            World.addComponent(world, entity, "size", {
                width = blockWidth,
                height = blockHeight
            })

            World.addComponent(world, entity, "color", {
                r = 0.784,
                g = 0.776,
                b = 0.843
            })

            World.addComponent(world, entity, "brick", true)
        end
    end
    
end

return Bricks
