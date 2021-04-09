Tiles = {}

function Tiles.load()
    Tiles.spritesheet = love.graphics.newImage("Assets/TILESET/PixelPackTOPDOWN8BIT.png")
    Tiles.quads = {}
    local width, height = Tiles.spritesheet:getDimensions()

    for y = 0, height - 16, 16 do
      for x = 0, width - 16, 16 do
        table.insert(Tiles.quads, love.graphics.newQuad(x, y, 16, 16, width, height))
      end
    end
end
