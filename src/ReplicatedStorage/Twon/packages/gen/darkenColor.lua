return function (originalColor: Color3, amount: number)
   assert(typeof(originalColor) == "Color3", `color3 expected got {typeof(originalColor)}`)
   assert(typeof(amount) == "number", `number expected got {typeof(amount)}`)

   amount = math.clamp(amount, 0, 1)
   local r, g, b = originalColor.r, originalColor.g, originalColor.b
   r = r * (1 - amount)
   g = g * (1 - amount)
   b = b * (1 - amount)
   
   return Color3.new(r, g, b)
end