Player = {}
function Player.load()
  local idleDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Idle D.png")
  Player.idleD = createAnim(idleDsrc, 1, 1)
  local idleRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Idle R.png")
  Player.idleR = createAnim(idleRsrc, 1, 1)
  local idleUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Idle U.png")
  Player.idleU = createAnim(idleUsrc, 1, 1)

  local walkRate = 4
  local walkDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Walk D.png")
  Player.walkD = createAnim(walkDsrc, 4, walkRate)
  local walkRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Walk R.png")
  Player.walkR = createAnim(walkRsrc, 4, walkRate)
  local walkUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Walk U.png")
  Player.walkU = createAnim(walkUsrc, 4, walkRate)

  local pushRate = 3
  local pushDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Push D.png")
  Player.pushD = createAnim(pushDsrc, 3, pushRate)
  local pushRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Push R.png")
  Player.pushR = createAnim(pushRsrc, 3, pushRate)
  local pushUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Push U.png")
  Player.pushU = createAnim(pushUsrc, 3, pushRate)

  local attackRate = 4
  local attackDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Attack D.png")
  Player.attackD = createAnim(attackDsrc, 2, attackRate)
  local attackRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Attack R.png")
  Player.attackR = createAnim(attackRsrc, 2, attackRate)
  local attackUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Attack U.png")
  Player.attackU = createAnim(attackUsrc, 2, attackRate)

  local hurtRate = 2
  local hurtDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Hurt D.png")
  Player.hurtD = createAnim(hurtDsrc, 1, hurtRate)
  local hurtRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Hurt R.png")
  Player.hurtR = createAnim(hurtRsrc, 1, hurtRate)
  local hurtUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Hurt U.png")
  Player.hurtU = createAnim(hurtUsrc, 1, hurtRate)

  local jumpRate = 3
  local jumpDsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog JumpRoll D.png")
  Player.jumpD = createAnim(jumpDsrc, 3, jumpRate)
  local jumpRsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog JumpRoll R.png")
  Player.jumpR = createAnim(jumpRsrc, 3, jumpRate)
  local jumpUsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog JumpRoll U.png")
  Player.jumpU = createAnim(jumpUsrc, 3, jumpRate)

  local deathRate = 1
  local deathsrc = love.graphics.newImage("Assets/SPRITES/HEROS/spritesheets/HEROS8bit_Dog Death.png")
  Player.death = createAnim(deathsrc, 2, deathRate)

  Player.currentAnim = Player.idleD

  Player.size = scale

  Player.x = 15
  Player.y = 15

  Player.speed = 16
  Player.velocity = {0, 0}

  Player.dir = "d"
end

function Player.update(deltaTime)
  local finished = updateAnimation(Player.currentAnim, deltaTime)
  Player.velocity = {0, 0}
  if love.keyboard.isDown("up") then
    Player.velocity[2] = -Player.speed
  elseif love.keyboard.isDown("down") then
    Player.velocity[2] = Player.speed
  end
  if love.keyboard.isDown("left") then
    Player.velocity[1] = -Player.speed
  elseif love.keyboard.isDown("right") then
    Player.velocity[1] = Player.speed
  end
  if joystick then
    dir = joystick:getHat(1)
    if (dir == "d") or (dir == "ld") or (dir == "rd") then
      Player.velocity[2] = Player.speed
    elseif (dir == "u") or (dir == "lu") or (dir == "ru") then
      Player.velocity[2] = -Player.speed
    end
    if (dir == "l") or (dir == "ld") or (dir == "lu") then
      Player.velocity[1] = -Player.speed
    elseif (dir == "r") or (dir == "rd") or (dir == "ru") then
      Player.velocity[1] = Player.speed
    end
  end

  Player.x = Player.x + Player.velocity[1] * deltaTime * scale
  Player.y = Player.y + Player.velocity[2] * deltaTime * scale

  if Player.velocity[1] > 0 then
    Player.currentAnim = Player.walkR
    Player.dir = "r"
  elseif Player.velocity[1] < 0 then
    Player.currentAnim = Player.walkR
    Player.dir = "l"
  elseif Player.velocity[2] > 0 then
    Player.currentAnim = Player.walkD
    Player.dir = "d"
  elseif Player.velocity[2] < 0 then
    Player.currentAnim = Player.walkU
    Player.dir = "u"
  else
    if Player.dir == "r" then
      Player.currentAnim = Player.idleR
    elseif Player.dir == "l" then
      Player.currentAnim = Player.idleR
    elseif Player.dir == "d" then
      Player.currentAnim = Player.idleD
    elseif Player.dir == "u" then
      Player.currentAnim = Player.idleU
    end
  end

end

function Player.draw()
  drawAnimatedSprite(Player.currentAnim, Player.x, Player.y, Player.size, (Player.dir == "l"))
end
