local HttpService = game:GetService("HttpService")
local packages = script.packages

--//dependencies
local xtypeof = require(packages.xtypeof)
local states = require(packages.state)
local signals = require(packages.signals)
local errors = require(packages.errors)
local form = require(packages.form)

local genFolder = packages.gen
--[=[
   lib for generate random roblox objects
]=]
local generation = {
   color3 = require(genFolder.color3),
   darkenColor = require(genFolder.darkenColor),
   udmi = require(genFolder.udmi),
   vector3 = require(genFolder.vector3),
   udmi2 = require(genFolder.udmi2),
}

local Twon do
   Twon = {
      State = states,
      Generation = generation,
   }

   --[=[
      I only use it to avoid mistakes in the future.
   ]=]
   function Twon.CreateObjective(goal: {Instance: Instance, Goal: {[string]: any}})
      assert(goal.Instance, "instance expected")
      assert(goal.Goal, "goal expected")

      return goal
   end

   --[=[
      How use that? Simple, objective is a table whos contains: Goal {propName = propTarget}, Instance: Instance Target
      
      @param baseInfo: TweenInfo
      ```lua
         local TwonObject = Twon.Create(TweenInfo.new(1, Enum.EasingStyle.Quad))
      ```
   ]=]
   function Twon.Create(baseInfo: TweenInfo)
      assert(typeof(baseInfo) == "TweenInfo", `info expected got {typeof(baseInfo)}`)

      local twonObject = {}
      twonObject._states = {}
      
      twonObject.Played = signals.new("Played")
      twonObject.Stopped = signals.new("Stopped")
      
      type goal = table

      --[=[
         example
         ```lua
            local MultiplePartsResize = Twon.Create(TweenInfo.new(5, Enum.EasingStyle.Quad))

            MultiplePartsResize:forList(partList, function()
               return {Size = Twon.Generation.vector3(2,10)}
            end)

            MultiplePartsResize:Play()
         ```
      ]=]
      function twonObject:forList(list: table, callback: (target: Part)->goal)
         assert(typeof(list) == "table", "table is invalid!")
         
         for _, object: any in list do
            table.insert(self._states, states.makeState(HttpService:GenerateGUID(false):sub(1,5)):tween(
               object,
               callback(object),
               baseInfo
            )) 
         end
      end

      function twonObject:insert(twonState: any)
         if xtypeof(twonState) ~= "twon-state" then
            error("twon state expected")
         end
         
         self._states[twonState] = twonState
      end

      function twonObject:Play()
         for _, state in self._states do
            if xtypeof(state) ~= "twon-state" then 
               errors:throw(`self._state has non valid objects`, 0)
            end

            state:play()
         end
      end

      function twonObject:Stop()
         for _, state in self._states do
            if xtypeof(state) == "twon-state" then 
               errors:throw(`self._state has non valid objects`, 0)
            end

            state:stop()
         end
      end

      return twonObject
   end
end

type signals = typeof(signals.new())

return Twon