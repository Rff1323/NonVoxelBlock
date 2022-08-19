local ClientBuilder = {}
local indicatorPart
--local partStorage = Game.GetService("PartStorage")

function ClientBuilder:Start()
  local timer = Timer.new(5, function()
    local yaw = Player.CurPlayer:getRotationYaw()
    yaw = -yaw % 360
    local pitch = Player.CurPlayer:getRotationPitch()
    pitch = -pitch % 360
    Lib.emitEvent("UpdateYawText",yaw,pitch)
  end)
  timer.Loop = true
  timer:Start()
end
--
function ClientBuilder:ShowIndicator(partSample)
  local player = Player.CurPlayer
  indicatorPart = partSample:Clone()
  local map = player.map
  indicatorPart.Parent = map.Root
  local frontPos = player:getFrontPos(3,false,false)
  indicatorPart.WorldPosition = Global.Function:RoundV3(frontPos)
  indicatorPart.WorldRotation = Vector3.new(1,1,1)
  
  timer = Timer.new(1,function()
    local pos = Player.CurPlayer:getFrontPos(3,false,false)
    indicatorPart.WorldPosition = Global.Function:RoundV3(pos)
  end)
  --
  timer[userID].Loop = true
  timer[userID]:Start()
    --
end
--
PackageHandlers.registerClientHandler("ShowIndicatorClient",function(player,table)
  ClientBuilder:ShowIndicator(table[1])
end)
--
return ClientBuilder