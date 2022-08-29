local Function = {}
local partStorage = Game.GetService("PartStorage")
local cfg = Entity.GetCfg("myplugin/player1")
local ProcessTable = {}

function Function:Round(number)
  local dec = number - math.floor(number)

  if number < 0 and dec == 0.5 then
    return math.ceil(number)
  end
  
  if dec >= 0.5 then
    return math.ceil(number)
  else
    return math.floor(number)
  end
end
--
function Function:RoundV3(vector3)
  --print("X:"..tostring(vector3.X)..",Y:"..tostring(vector3.Y)..",Z:"..tostring(vector3.Z))
  return Vector3.new(Function:Round(vector3.x),Function:Round(vector3.y),Function:Round(vector3.z))
end
--
function Function:RotationToV3(yaw,pitch)
  local _yaw = -yaw % 360
  local _pitch = -pitch % 360
  
  local z = math.cos(math.rad(_yaw))*math.cos(math.rad(_pitch))
  local y = math.sin(math.rad(_pitch))
  local x = math.sin(math.rad(_yaw))*math.cos(math.rad(_pitch))
  
  return Vector3.new(x,y,z)
end

function Function:CreateBlock (Part,Creator,Location)
  local item = Creator:getHandItem()

  if item then
    local tempName = string.gsub(item:full_name(), "myplugin/", "")
    print(tempName)
    local block = partStorage:FindFirstChild(tempName)

    if block then
      local addition = Creator:getPosition() - Location
      addition = addition:normalize()
      addition = addition * 0.1
    
      Location = Location + addition
      Location = Function:RoundV3(Location)

      if Part then
        if Location == Part.WorldPosition then
          return
        end
      end

      block = block:Clone()
      local stackNum = item:stack_count_max() - item:stack_free()

      block.Parent = Creator.map.Root
      block.WorldPosition = Location
      local BlockEvent = block:GetEvent("OnClick")
      BlockEvent:Bind(function (part,entity,pos)
        Function:CreateBlock(part,entity,pos)
      end)

      local var = Creator:tray():query_trays(function ()
        return true
      end) 

      for _, data in pairs(var) do
        print(tostring(data.tid).." : "..tostring(data.tray:avail_capacity()))
      end

      if (stackNum > 1) then
        item:set_stack_count(stackNum-1)
      else
        Creator:tray():fetch_tray(item:tid()):remove_item(item:slot())
      end

      return
    end
  end
  Function:DestroyBlock(Part)
end
--
function Function:DestroyBlock(part) 
  if (part) then
    local id = part.ID
    if (ProcessTable[id]) then
      ProcessTable[id].click = ProcessTable[id].click + 1
      print(part.Name)
        if(ProcessTable[id].click <= 2) then
          ProcessTable[id].timer:Start()
        else
          local params = {
            item = Item.CreateItem("myplugin/"..part.Name,1),
            map = part.Map,
            pos = part.WorldPosition
          }
          part:Destroy()
          local dropItem = DropItemServer.Create(params)
          ProcessTable[id] = nil
        end
    else
        ProcessTable[id] = {click = 1, part = part, timer = Timer.new(100,function ()
            ProcessTable[id] = nil
        end)}
        ProcessTable[id].timer:Start()
    end
  end
end
--
function Function:RandomText(param)
  return param
end
return Function