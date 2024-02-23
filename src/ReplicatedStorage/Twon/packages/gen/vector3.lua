local Random = Random.new()

return function (min: number, max: number)
   assert(typeof(min) == "number", `number expected got {min}`)
   assert(typeof(max) == "number", `number expected got {max}`)

   return Vector3.new(
      Random:NextNumber(min, max),
      Random:NextNumber(min, max),
      Random:NextNumber(min, max)
   )
end