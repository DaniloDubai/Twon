local TweenService = game:GetService("TweenService")
local package = script.Parent
local errors = require(package.errors)
local xtypeof = require(package.xtypeof)

--//states
local states, mt do
   states = {}
   mt = {}
   mt.__tostring = function()
      return "twon-state"
   end
   mt.__call = function(self)
      return self.name or "invalid-name"
   end
   mt.__index = mt

   --[=[
      creates an new state for tween
      @param name: string not necessary only for depuration
   ]=]
   function states.makeState(name: string?)
      local state = {}

      --//private
      state._tweenGoal = nil :: Tween
      state._markedInfo = nil :: TweenInfo
      
      --//public
      state.name = name

      function state:tween(target: Instance, goal: any, info: TweenInfo?): TwonState
         assert(typeof(target) == "Instance", `instance expected got {typeof(target)}`)
         assert(typeof(goal) == "table", `table expected got {typeof(goal)}`)

         state._tweenGoal = TweenService:Create(target,(info or state._markedInfo), goal)
         
         return state
      end

      function state:play(): TwonState
         assert(self._tweenGoal, "TweenGoal is not created")
         
         self._tweenGoal:Play()
      end

      function state:stop(): TwonState
         assert(self._tweenGoal, "TweenGoal is not created")
         self._tweenGoal:Cancel()
      end   

      function state:_delete()
         assert(self._tweenGoal, "TweenGoal is not created")
         self._tweenGoal:Destroy()
         table.clear(self)
         setmetatable(self, nil)
      end

      setmetatable(state, mt)
      return state
   end
end

type TwonName = string
type TwonState = typeof(states.makeState()) & (_: any)->TwonName

return states