local ReplicatedStorage = game:GetService("ReplicatedStorage")
local partList = {}

for i = 1, 10 do
   local part = Instance.new("Part", workspace)
   table.insert(partList, i, part)
end

local Twon = require(ReplicatedStorage.Twon)
local MultiplePartsResize = Twon.Create(TweenInfo.new(5, Enum.EasingStyle.Quad))

MultiplePartsResize:forList(partList, function()
   return {Size = Twon.Generation.vector3(2,10)}
end)

MultiplePartsResize:Play()