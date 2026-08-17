-- create Entity, add components, remove Entity, count components

local World = {}

function World.new()

    return {
        nextEntityId = 0,
        entities = {},
        components = {
            position = {},
            size = {},
            velocity = {},
            color = {},
            paddle = {},
            ball = {},
            brick = {}
        }
    }
    
end


function World.createEntity(world)
    world.nextEntityId = world.nextEntityId + 1
    local entity = world.nextEntityId
    world.entities[entity] = true
    return entity
end


function World.addComponent(world, entity, componentName, data)
    world.components[componentName][entity] = data
end


function World.removeEntity(world, entity)
    world.entities[entity] = nil

    for _, componentStore in pairs(world.components) do
        componentStore[entity] = nil
    end
end


function World.countComponents(world, componentName)
    local count = 0

    for _ in pairs(world.components[componentName]) do
        count = count + 1
    end

    return count
end

return World
