Tile = class("Tile")

function Tile:initialize(obstructsMovement, obstructsSight)
	self.obstructsMovement = obstructsMovement
	self.explored = false
	self.obstructsSight = obstructsSight
end

Map = class("Map")

function Map:initialize(width, height)
	self.size = {width, height}
	self.tileSize = {love.graphics.getWidth() / self.size[1], love.graphics.getHeight() / self.size[2]}
	self.tileMap = {}
	self:generateCellularAutomata(0.45, 5)
end

function Map:generateCellularAutomata(fillProbability, iterations)
	for x = 1, self.size[1] do
		self.tileMap[x] = {}
		for y = 1, self.size[2] do
			self.tileMap[x][y] = Tile:new(true, true)
		end
	end
	for x = 2, self.size[1] - 1 do
		for y = 2, self.size[2] - 1 do
			if math.random() < fillProbability then
				self.tileMap[x][y] = Tile:new(true, true)
			else
				self.tileMap[x][y] = Tile:new(false, false)
			end
		end
	end
	for i = 1, iterations do
		local temp = {}
		for x = 1, self.size[1] do
			temp[x] = {}
			for y = 1, self.size[2] do
				temp[x][y] = self.tileMap[x][y]
			end
		end
		for x = 2, self.size[1] - 1 do
			for y = 2, self.size[2] - 1 do
				local numberOfWalls = self:countNeighbouringWalls(x, y)
				if temp[x][y].obstructsMovement == false then
					if numberOfWalls > 5 then
						temp[x][y].obstructsSight = true
						temp[x][y].obstructsMovement = true
					end
				elseif numberOfWalls < 4 then
					temp[x][y].obstructsSight = false
					temp[x][y].obstructsMovement = false
				end
			end
		end
		for x = 1, self.size[1] do
			for y = 1, self.size[2] do
				self.tileMap[x][y] = temp[x][y]
			end
		end
	end
end

function Map:countNeighbouringWalls(x, y)
	local sum = 0
	for i = -1, 1 do
		for j = -1, 1 do
			if self.tileMap[x + i][y + j].obstructsMovement then
				sum = sum + 1
			end
		end
	end
	return sum
end

function Map:generateRandomRooms(numberOfRooms, roomSize)
	for x = 1, self.size[1] do
		self.tileMap[x] = {}
		for y = 1, self.size[2] do
			self.tileMap[x][y] = Tile:new(true, true)
		end
	end
	
	local rooms = {}
	for i = 1, numberOfRooms do
		w = math.random(roomSize[1], roomSize[2])
		h = math.random(roomSize[1], roomSize[2])
		x = math.random(1, self.size[1] - w)
		y = math.random(1, self.size[2] - h)
		local currentRoom = Rectangle:new(x, y, w, h)
		
		local roomIntersects = false
		for _, otherRoom in pairs(rooms) do
			if currentRoom:intersects(otherRoom) then
				roomIntersects = true
				break
			end
		end
		
		if not roomIntersects then
			self:carveRoom(currentRoom)
			if #rooms ~= 0 then
				local center = currentRoom:center();
				local previousCenter = rooms[#rooms]:center()
				print(unpack(center))
				print(unpack(previousCenter))
				if math.random() > 0.5 then
					self:carveHorizontalTunnel(previousCenter[2], previousCenter[1], center[1]);
					self:carveVerticalTunnel(center[1], previousCenter[2], center[2]);
				else
					self:carveVerticalTunnel(previousCenter[1], previousCenter[2], center[2]);
					self:carveHorizontalTunnel(center[2], previousCenter[1], center[1]);
				end
			end
			table.insert(rooms, currentRoom)
		end
	end
end

function Map:carveRoom(room)
	for x = room.x1, room.x2 do
		for y = room.y1, room.y2 do
			self.tileMap[x][y].obstructsMovement = false
			self.tileMap[x][y].obstructsSight = false
		end
	end
end

function Map:carveVerticalTunnel(x, y1, y2)
	for y = math.min(y1, y2), math.max(y1, y2) do
		self.tileMap[x][y].obstructsSight = false
		self.tileMap[x][y].obstructsMovement = false
	end
end

function Map:carveHorizontalTunnel(y, x1, x2)
	for x = math.min(x1, x2), math.max(x1, x2) do
		self.tileMap[x][y].obstructsSight = false
		self.tileMap[x][y].obstructsMovement = false
	end
end

function Map:draw()
	for x = 1, self.size[1] do
		for y = 1, self.size[2] do
			love.graphics.setColor(0, 0, 255)
			if self.tileMap[x][y].obstructsSight then
				love.graphics.setColor(0, 0, 100)
			end
			love.graphics.rectangle("fill", (x-1)*self.tileSize[1], (y-1)*self.tileSize[2], self.tileSize[1], self.tileSize[2])
		end
	end
end