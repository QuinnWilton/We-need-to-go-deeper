Stack = class("Stack")

function Stack:initialize()
	self.Raw = {}
	self.n = 0 -- Hold the count for optimization lua 
	-- doesn't hold length by defualt and it's used
	-- everywhere here.
end

function Stack:push(o)
	self.n = self.n + 1
	self.Raw[self.n] = o
end

function Stack:pop()
	if self.n == 0 then return end
	retval, self.Raw[self.n] = self.Raw[self.n], nil
	-- No clue why, but it seems switching this way is
	-- a bit faster than two seperate assigments.
	self.n = self.n - 1
	return retval;
end

function Stack:peek()
	return self.Raw[self.n]
end