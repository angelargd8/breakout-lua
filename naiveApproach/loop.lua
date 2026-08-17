--- loop ---
-- game's logic and loop
-- state management, collision detection, and rendering

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

local WINDOW_WIDTH = 800
local WINDOW_HEIGHT = 600

-- game table 
local game = {}

-- paddle table
local paddle = {
    x = 360,
    y = 560,
    width = 100, 
    height = 20,
    speed = 500 -- pixels per second
}

-- ball table
local ball = {
    x = 400,
    y = 400,
    width = 25,
    height = 25, 
    dx = 200, -- velocity in x direction
    dy = -200,  --velocity in y direction

}

-- blocks table
local blocks = {}
local Finished = false

--------------------------


-- paddle movement function
local function movePaddle(dt)
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        paddle.x = paddle.x - paddle.speed * dt
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        paddle.x = paddle.x + paddle.speed * dt
    end

    -- keep paddle within window bounds
    if paddle.x < 0 then
        paddle.x = 0
    end

    if paddle.x + paddle.width > WINDOW_WIDTH then
        paddle.x = WINDOW_WIDTH - paddle.width
    end
end



--- ball movement function
local function moveBall(dt)
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt
end


local function bounceBallOnWalls()
    if ball.x <= 0 then
        ball.x = 0
        ball.dx = math.abs(ball.dx)
    end

    if ball.x + ball.width >= WINDOW_WIDTH then
        ball.x = WINDOW_WIDTH - ball.width
        ball.dx = -math.abs(ball.dx)
    end

    if ball.y <= 0 then
        ball.y = 0
        ball.dy = math.abs(ball.dy)
    end

    if ball.y + ball.height >= WINDOW_HEIGHT then
        -- Game over condition
        print("game over")
        Finished = true
        love.event.quit()
    end
end


local bounceBallOnPaddle = function()
    if ball.y + ball.height >= paddle.y and
       ball.x + ball.width >= paddle.x and
       ball.x <= paddle.x + paddle.width then
        ball.dy = -math.abs(ball.dy)
    end
end


local function rectanglesOverlap(a, b)
    return a.x < b.x + b.width
        and a.x + a.width > b.x
        and a.y < b.y + b.height
        and a.y + a.height > b.y
end


local function resetBlocks()
    blocks = {}

    local rows = 3
    local columns = 4
    local blockWidth = 170
    local blockHeight = 60
    local gap = 12
    local startX = 42
    local startY = 60

    for row = 1, rows do
        for column = 1, columns do
            table.insert(blocks, {
                x = startX + (column - 1) * (blockWidth + gap),
                y = startY + (row - 1) * (blockHeight + gap),
                width = blockWidth,
                height = blockHeight
            })
        end
    end
end

local function bounceBallOnBlocks()
    for i = #blocks, 1, -1 do
        local block = blocks[i]

        if rectanglesOverlap(ball, block) then
            table.remove(blocks, i)
            ball.dy = -ball.dy

            if #blocks == 0 and not Finished then
                Finished = true
                print("you win")
                love.event.quit()
            end

            return
        end
    end
end


--------------------------

-- se ejecuta 1 vez al inicio del juego
function game.load()
    -- load assets, initialize variables, etc.
    love.graphics.setBackgroundColor(0.29, 0.251, 0.388)
    resetBlocks()
end

-- se ejecuta cada frame, dt es el tiempo transcurrido desde el último frame
function game.update(dt)
    -- update game state, handle input, etc.

    -- paddle movement
    movePaddle(dt)

    -- ball movement
    moveBall(dt)

    -- ball bouncing
    bounceBallOnWalls()
    bounceBallOnPaddle()
    bounceBallOnBlocks()
end

-- se ejecuta cada frame, después de update, para dibujar en pantalla
function game.draw()
    -- render the game

    -- draw paddle
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle(
        "fill",
        paddle.x, 
        paddle.y, 
        paddle.width,
        paddle.height
    )

    -- draw ball
    love.graphics.setColor(0.976, 0.149, 0.447)
    love.graphics.rectangle(
        "fill",
        ball.x,
        ball.y,
        ball.width,
        ball.height
    )

    -- draw blocks
    love.graphics.setColor(0.784, 0.776, 0.843)
    for _, block in ipairs(blocks) do
        love.graphics.rectangle(
            "fill", 
            block.x, 
            block.y, 
            block.width, 
            block.height)
    end

end

return game