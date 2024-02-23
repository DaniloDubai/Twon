local Random = Random.new()

return function (min: number, max: number, mode: "Offset"|"Scale")
   assert(typeof(min) == "number", `number expected got {min}`)
   assert(typeof(max) == "number", `number expected got {max}`)

   if mode == "Offset" then
      return UDim2.fromOffset(Random:NextNumber(min, max), Random:NextNumber(min, max))
   elseif mode == "Scale" then
      return UDim2.fromScale(Random:NextNumber(min, max), Random:NextNumber(min, max))
   else
      error(`{mode} not exist`)
   end
end