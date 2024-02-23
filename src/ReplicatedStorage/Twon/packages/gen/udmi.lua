local Random = Random.new()

return function (min: number, max: number, mode: "Offset"|"Scale")
   assert(typeof(min) == "number", `number expected got {min}`)
   assert(typeof(max) == "number", `number expected got {max}`)

   if mode == "Offset" then
      return UDim.new(0, Random:NextNumber(min, max))
   elseif mode == "Scale" then
      return UDim.new(Random:NextNumber(min, max), 0)
   else
      error(`{mode} not exist`)
   end
end