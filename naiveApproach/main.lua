--- main ---
-- here are the main functions of the game, which are called by LOVE framework
-- the callbacks are: load, update, draw

-- load the loop module
local game = require("loop")

function love.load()
    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end
