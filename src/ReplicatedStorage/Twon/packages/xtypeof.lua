return function (target: any?, objective: string)

   local _type = typeof(target)

   if _type == "Instance" then
      --case is an instance
      assert(type(objective), `string expected got {typeof(objective)}`)
      return target:IsA(objective)
   elseif _type == "table" then
      -- case is an custom object
      local definitiveType = tostring(target)
      if definitiveType:find("table") then return _type end
      
      return definitiveType
   else
      return _type
   end
end