local moonshine = require 'moonshine'
require "Player"
require "Tiles"
require "Map1"

resolution = {160, 144}
realRes = {160, 144}
scale = 1
origin = {0, 0}
camera = {0, 0}
map = Map1

function love.load()
  love.window.setMode(resolution[1], resolution[2], {fullscreen = true})
  local width, height, flags = love.window.getMode()
  realRes[2] = height
  realRes[1] = resolution[1] * height / resolution[2]
  scale = realRes[2] / resolution[2]
  origin[1] = (width / 2) - (realRes[1] / 2)

  love.graphics.setScissor(origin[1], origin[2], realRes[1], realRes[2])
  love.graphics.setDefaultFilter("nearest", "nearest")

  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]
  Tiles.load()
  Player.load()

  effect = moonshine(moonshine.effects.glow)
                    .chain(moonshine.effects.vignette)
                    .chain(moonshine.effects.crt)
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  Player.update(dt)
end


function love.draw()
  effect(function()
    drawMap(map, Tiles, {0, 0})
    Player.draw()
  end)
end

function createAnim(image, frames, framerate)
  local animation = {}
  animation.spritesheet = image;
  animation.quads = {}

  for x = 0, (frames - 1) * 16, 16 do
    table.insert(animation.quads, love.graphics.newQuad(x, 0, 16, 16, image:getDimensions()))
  end

  animation.duration = frames / framerate
  animation.currentTime = 0

  return animation
end

function updateAnimation(animation, deltaTime)
  animation.currentTime = animation.currentTime + deltaTime
  if animation.currentTime >= animation.duration then
    animation.currentTime = animation.currentTime - animation.duration
    return true
  else
    return false
  end
end

function drawAnimatedSprite(animation, x, y, size, flip)
  local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
  local xSize = size
  local xAnchor = 0
  if flip then
    xSize = -xSize
    xAnchor = 16
  end

  x = math.floor(x - camera[1] + 0.5) * size
  y = math.floor(y - camera[2] + 0.5) * size
  love.graphics.draw(animation.spritesheet, animation.quads[spriteNum], x + origin[1], y + origin[2], 0, xSize, size, xAnchor)
end

function drawMap(map, tiles, offset)
  for y, row in pairs(map.tiles) do
    for x, index in pairs(row) do
      drawTile(tiles, index, (x + offset[1] - 1) * 16 * scale, (y + offset[2] - 1) * 16 * scale, false)
    end
  end
end

function drawTile(tiles, index, x, y, flip)
  local xSize = scale
  local xAnchor = 0
  if flip then
    xSize = -xSize
    xAnchor = 16
  end
  love.graphics.draw(tiles.spritesheet, tiles.quads[index], x + origin[1], y + origin[2], 0, xSize, scale, xAnchor)
end

function bitcheck(value, bit)
  value = math.floor(a / (2^bit))
  return value % 2
end
