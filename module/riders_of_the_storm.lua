print("module - start");

---@class epsilon
local epsilon = select(2, ...)

local module = {}


function module:attach()
	print("register riders of the storm module")
end

function module:detach()
	print("remove riders of the storm module")
end

epsilon.registerModule (self, module, "riders_of_the_storm", "Riders of the Storm")

print("module - end");