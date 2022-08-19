
local Building = {}

local cfg = Entity.GetCfg("myplugin/player1")
local indicatorPart = {}
local timer = {}
local playerList = {}
local partStorage = Game.GetService("PartStorage")
local rangeMultiplier = 3

function Building:ShowIndicator(plr)
  if (plr.isPlayer) then
    local userID = plr.platformUserId

    playerList[userID] = plr

    indicatorPart[userID] = partStorage:FindFirstChild("Indicator"):Clone()
    local event = indicatorPart[userID]:GetEvent("OnClick")
    event:Bind(function(part,entity,pos)
      print("KEPENCET ",indicatorPart[userID]:getPosition())
      local block = partStorage:FindFirstChild("Build_Cbbl"):Clone()
      block.Parent = playerList[userID].map.Root
      block.WorldPosition = indicatorPart[userID]:getPosition()
    end)
    --  
    
    --
    
    timer[userID] = Timer.new(1,function()
      local player = playerList[userID]
      local map = player.map
      indicatorPart[userID].Parent = map.Root
      local startPos = Vector3.new(player:getPosition().x,player:getPosition().y+1.5,player:getPosition().z)
      local direction = Global.Function:RotationToV3(player:getRotationYaw(),player:getRotationPitch())
      local hit = map:RayCast(startPos,direction,rangeMultiplier,true)
      --print("x : "..tostring(Global.Function:Round(direction.x*10)/10).." y : "..tostring(Global.Function:Round(direction.y*10)/10).." z : "..tostring(Global.Function:Round(direction.z*10)/10))
      
      local pos = startPos + direction * rangeMultiplier
      --print(#hit)
      if (#hit > 0) then
        for _, hitRes in pairs(hit) do
          if(hitRes.Instance ~= indicatorPart[userID]) then
            pos = hitRes.Position
            break
          end
        end
      end
      indicatorPart[userID].WorldRotation = Vector3.new(1,1,1)
      indicatorPart[userID].WorldPosition = Global.Function:RoundV3(pos)
    end)
    --
    timer[userID].Loop = true
    timer[userID]:Start()
    --
    
  end
end
--
PackageHandlers.registerServerHandler("ShowIndicator",function(player)
  Building:ShowIndicator(player)
end)
  --

return Building