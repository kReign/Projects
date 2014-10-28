Camera = {}

Camera.position = {}
Camera.position.x = 0.0
Camera.position.y = 0.0

Camera.target = {}
Camera.target.x = 0
Camera.target.y = 0

Camera.lerp_amount = 1

function Camera.Update(dt)
	Camera.position.x = Camera.position.x + (Camera.target.x - Camera.position.x) * Camera.lerp_amount
	Camera.position.y = Camera.position.y + (Camera.target.y - Camera.position.y) * Camera.lerp_amount
	
	Camera.position.x = Camera.position.x - love.window.getWidth()/2
	Camera.position.y = Camera.position.y - love.window.getHeight()/2
end

function Camera:SetTarget(x, y)
	Camera.target.x = math.max(0, x)
	Camera.target.y = math.max(0, y)
end