local Function = {}

function Function:Round(number)
  local dec = number - math.floor(number)
  
  if dec >= 0.5 then
    return math.ceil(number)
  else
    return math.floor(number)
  end
end
--
function Function:RoundV3(vector3)
  --print("X:"..tostring(vector3.X)..",Y:"..tostring(vector3.Y)..",Z:"..tostring(vector3.Z))
  return Vector3.new(Global.Function:Round(vector3.x),math.ceil(vector3.y),Global.Function:Round(vector3.z))
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

--
function Function:RandomText(param)
  return param
end
return Function