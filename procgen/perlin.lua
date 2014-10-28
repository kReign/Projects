Perlin = {}

Perlin.noise = {}

function Perlin.GenerateNoise(width, height)
	for i=0,width do
		Perlin.noise[i] = {}
		for j=0,height do
			Perlin.noise[i][j] = math.random()
		end
	end
end

function Perlin.SmoothNoise(x, y)
	fractX = x - math.floor(x)
	fractY = y - math.floor(y)
	
	x1 = math.fmod(math.floor(x) + width, width)
	y1 = math.fmod(math.floor(y) + height, height)
	
	x2 = math.fmod(math.floor(x) + width - 1, width)
	y2 = math.fmod(math.floor(y) + height - 1, height)
	
	value = 0.0
	value = value + fractX * fractY * Perlin.noise[x1][y1]
	value = value + fractX * (1-fractY) * Perlin.noise[x1][y2]
	value = value + (1-fractX) * fractY * Perlin.noise[x2][y1]
	value = value + (1-fractX) * (1-fractY) * Perlin.noise[x2][y2]
	
	return value
end

function Perlin.Turbulence(x, y, size)
	value = 0.0
	initial_size = size
	
	while size >= 1 do
		value = value + Perlin.SmoothNoise(x / size, y / size) * size
		size = size / 2.0
	end
	
	return (128*value) / initial_size
end