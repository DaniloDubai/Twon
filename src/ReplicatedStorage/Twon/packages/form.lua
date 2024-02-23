local package = script.Parent

local state = require(package.state)
local errors = require(package.errors)

type children = {
   Instance: Instance,
   Goal: table
}

return function (target: table, info: TweenInfo)
   assert(typeof(info) == "TweenInfo", "tween info expected.")

   local result = {} :: {[number]: typeof(state.makeState())}
   
   for _, children: children in ipairs(target) do
      if not children.Instance then errors:throw(`children.Instance is not finded`, 0) end
      if not children.Goal then errors:throw(`children.Goal is not finded`, 0) end
      for propName: string, propTarget: any in children.Goal do errors:propertyExist(children.Instance, propName).caseNot(error, `property named {propName} is not valid for {propTarget}`) end

      local _state = state.makeState()
      _state:tween(children.Instance, children.Goal, info)

      table.insert(result, _state)
   end

   return result
end