local ReusableFunctions = {}

function ReusableFunctions.getPathFromString(parent, pathString)
	local parts = pathString:split(".")  
	local currentInstance = parent

	for _, part in ipairs(parts) do
		if currentInstance then

			currentInstance = currentInstance:FindFirstChild(part)  -- Find  child with name of current part

		else
			break  
		end
	end

	return currentInstance  
end

ReusableFunctions.suffixes = {
	{1e21, "S"},
	{1e18, "Qi"},
	{1e15, "Qa"},
	{1e12, "T"},
	{1e9, "B"},
	{1e6, "M"},
	{1e3, "K"}
}

function ReusableFunctions.formatWithDecimals(value)
	if value % 1 == 0 then
		return string.format("%.0f", value)
	else
		return string.format("%.2f", value)
	end
end

function ReusableFunctions.formatNumber(num, index)
	if index > #ReusableFunctions.suffixes or num < 1e3 then
		return ReusableFunctions.formatWithDecimals(num)
	end

	local magnitude, symbol = ReusableFunctions.suffixes[index][1], ReusableFunctions.suffixes[index][2]

	if num >= magnitude then
		return ReusableFunctions.formatWithDecimals(num / magnitude) .. symbol
	else
		return ReusableFunctions.formatNumber(num, index + 1)
	end
end


local boostFactor = 1.5

function ReusableFunctions.getRandomWeightedSelection(weights, luckMultiplier)
	-- Adjust the weights based on luck multiplier and boost factor
	local adjustedWeights = {}
	local totalWeight = 0

	-- Assuming `weights` is an array with corresponding names as keys
	for name, weight in pairs(weights) do
		local luckAdjustment = (1 - (weight / 100)) * boostFactor
		local adjustedWeight = weight * luckMultiplier ^ luckAdjustment
		adjustedWeights[name] = adjustedWeight
		totalWeight = totalWeight + adjustedWeight
	end

	-- out of hundred it
	local normalizedWeights = {}
	for name, adjustedWeight in pairs(adjustedWeights) do
		local normalizedWeight = (adjustedWeight / totalWeight) * 100
		normalizedWeights[name] = normalizedWeight
	end

	-- Calculate the distribution of the new weights
	local cumulativeWeight = 0
	local totalWeight = 0
	for _, weight in pairs(normalizedWeights) do
		totalWeight = totalWeight + weight
	end

	local randomChoice = math.random() * totalWeight

	-- search where the random number falls in the weights or whatever
	for name, weight in pairs(normalizedWeights) do
		cumulativeWeight = cumulativeWeight + weight
		if randomChoice <= cumulativeWeight then
			return name -- key
		end
	end
end

-- Example usage with luck multiplier values
--[[ 
    weights = {Pet1 = 70, Pet2 = 20, Pet3 = 7, Pet4 = 2.1, Pet5 = 0.9}
    luck = 1, 10, 100, 5, 2, 7, etc.
    boostFactor = 1.5, unless changed
]]

-- When luck multiplier is 10 (high luck boost)






return ReusableFunctions


