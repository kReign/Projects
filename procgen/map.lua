require "perlin"

Map = {}
Map.current_map = {}
Map.sea_level = .51

function Map:Generate(width, height)
	math.randomseed( os.time() )
	Perlin.GenerateNoise(width, height)
	
	for i=0,width do
		Map.current_map[i] = {}
		for j=0,height do
			level = Perlin.Turbulence(i, j, 32)/255
			if level < Map.sea_level and level > Map.sea_level/1.1 then Map.current_map[i][j] = 2
			elseif level < Map.sea_level/1.05 then Map.current_map[i][j] = 1
			elseif level > .7 then Map.current_map[i][j] = 5
			elseif level > .60 then Map.current_map[i][j] = 4
			elseif level > Map.sea_level then Map.current_map[i][j] = 3 end
		end
	end
end