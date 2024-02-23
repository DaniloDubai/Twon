local RunService = game:GetService("RunService")
local errors do
   errors = {}
   errors._listErrorsOnStudio = true;
   errors._baseLevel = 0;   

   function errors:throw(mensage: string, level: number?)
      if not self._listErrorsOnStudio and RunService:IsStudio() then
         return
      end
      assert(type(mensage) == "string", `string expected got {typeof(mensage)}`)
      
      error(
         mensage,
         level or self._baseLevel
      )
   end

   function errors:propertyExist(target: Instance, propertyName: string)
      local sucess = pcall(function()
         target[propertyName] = target[propertyName]
      end)

      local options = {}

      function options.caseNot(callback)
         if not sucess then
            callback()
         end
      end

      return options
   end

end

return errors