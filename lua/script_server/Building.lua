
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
      Global.Function:CreateBlock(entity,indicatorPart[userID]:getPosition())
    end)
--
    
    timer[userID] = Timer.new(1,function()
      local player = playerList[userID]
      local map = player.map
      indicatorPart[userID].Parent = map.Root
      local startPos = Vector3.new(player:getPosition().x,player:getPosition().y+1.5,player:getPosition().z)
      local direction = Global.Function:RotationToV3(player:getRotationYaw(),player:getRotationPitch())
      local hit = map:RayCast(startPos,direction,rangeMultiplier,true)
      
      local pos = startPos + direction * rangeMultiplier
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