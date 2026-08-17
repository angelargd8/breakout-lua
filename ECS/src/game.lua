-- steps:
-- 1. draw paddle
-- 2. paddle movement
-- 3. draw ball
-- 4. ball movement
-- 5. ball bouncing
-- 6. collision detection
-- 7. create bricks
-- 8. detect collision with bricks
-- 9. win conditions


local World = require("src.ECS.world")

local Paddle = require("src.Entities.paddle")
local Ball = require("src.Entities.ball")
local Bricks = require("src.Entities.bricks")

local PaddleInputSystem = require("src.Systems.paddleInputSystem")
local MovementSystem = require("src.Systems.movementSystem")
local WallCollisionSystem = require("src.Systems.wallCollisionSystem")
local PaddleCollisionSystem = require("src.Systems.paddleCollisionSystem")
local BrickCollisionSystem = require("src.Systems.brickCollisionSystem")
local RenderSystem = require("src.Systems.renderSystem")

local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600


local game = {}
local world = nil
local gameState = nil

function game.load()
    love.graphics.setBackgroundColor(0.29, 0.251, 0.388)

    world = World.new()
    gameState = {
        finished = false,
        message = nil
    }

    Paddle.create(world)
    Ball.create(world)
    Bricks.createAll(world)
end



function game.update(dt)
    if gameState.finished then
        return
    end

    PaddleInputSystem.update(world, dt, WINDOW_WIDTH)
    MovementSystem.update(world, dt)
    WallCollisionSystem.update(world, gameState, WINDOW_WIDTH, WINDOW_HEIGHT)

    if gameState.finished then
        return
    end

    PaddleCollisionSystem.update(world)
    BrickCollisionSystem.update(world, gameState)
end


function game.draw()
    RenderSystem.draw(world, gameState)
end

return game
