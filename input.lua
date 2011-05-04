function love.mousepressed (x, y, button)
	vec = Vector2d:new(x,y)
	table.insert(curInput, {t = "mousedown", v = {pos=vec, btn=button} })
end

function love.mousereleased (x, y, button)
	vec = Vector2d:new(x,y)
	table.insert(curInput, {t = "mouseup", v = {pos=vec, btn=button}  })
end

function love.keypressed (key, unicode)
	table.insert(curInput, {t = "keypress", v = key})
end

function love.keyreleased (key)
	table.insert(curInput, {t = "keyup", v = key})
end
