local ReusableFunctions = {}
--... other code
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


