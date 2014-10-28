require "camera"
require "map"

tilesize = love.window.getWidth()/40
--tilesize = love.window.getWidth()/24

height = 255
width = 255

function love.load()
	love.window.setMode(800, 600, {vsync = false})
	
	Map:Generate(width, height)
	
	song = love.audio.newSource("smb3.mp3")
	--love.audio.play(song)
	
	tree = love.graphics.newImage("assets/tree.png")
	
	grass = {0, 181, 51, 255}
	hill = {0, 156, 5, 255}
	ocean = {4, 120, 184, 255}
	shallow = {158, 255, 249, 255}
	beach = {255, 242, 184, 255}
	mountain = {163, 163, 163, 255}
		
	cameraspeed = 2
	x, y = math.floor(love.window.getWidth()/2), math.floor(love.window.getHeight()/2)
end

function love.update(dt)
	if love.keyboard.isDown('left') then x = x - cameraspeed*dt end
	if love.keyboard.isDown('right') then x = x + cameraspeed*dt end
	if love.keyboard.isDown('up') then y = y - cameraspeed*dt end
	if love.keyboard.isDown('down') then y = y + cameraspeed*dt end
	
	if love.keyboard.isDown('r') then Map:Generate(width, height) end
	
	x = math.min(math.max(0, x), love.window.getWidth())
	y = math.min(math.max(0, y), love.window.getHeight())
	
	Camera:SetTarget(x, y)
	Camera.Update(dt)
	
end

function love.draw()
	color = {0, 255, 0, 255}
	for i=0,width do
		for j=0,height do
			if Map.current_map[i][j] == 2 then color = shallow
			elseif Map.current_map[i][j] == 1 then color = ocean
			elseif Map.current_map[i][j] == 5 then color = mountain
			elseif Map.current_map[i][j] == 4 then color = hill
			elseif Map.current_map[i][j] == 3 then color = grass end
			
			love.graphics.setColor( color )
			
			love.graphics.rectangle("fill", (i - Camera.position.x)*tilesize, (j - Camera.position.y)*tilesize, tilesize, tilesize)
		end
	end
	
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("fill", x - Camera.position.x, y - Camera.position.y, tilesize, tilesize)
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.print('1', 0, 0)
	love.graphics.print('2', 0, 16)
	
	love.graphics.setColor(255,255,255,50)
	local x, y = love.mouse.getPosition()
    love.graphics.rectangle("fill", math.floor((x - tilesize/2)), math.floor((y - tilesize/2)), tilesize, tilesize)
	
end